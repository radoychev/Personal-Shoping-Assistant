import UIKit
import AVFoundation
import Vision

protocol CameraViewControllerDelegate: AnyObject {
    func cameraViewController(_ controller: CameraViewController, didDetectObjects objects: [DetectedObject])
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: CameraViewControllerDelegate?

    private var model: VNCoreMLModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high

        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)

        captureSession.startRunning()

        // Load the CoreML model
        do {
            model = try VNCoreMLModel(for: Redbul().model)
        } catch {
            print("Error loading model: \(error.localizedDescription)")
            model = nil // Explicitly set model to nil if loading fails
        }

    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        // Ensure the model is not nil before proceeding
        guard let model = model else {
            print("Model is nil, cannot perform object detection")
            return
        }

        let request = VNCoreMLRequest(model: model) { [weak self] (finishedRequest, error) in
            guard let results = finishedRequest.results as? [VNRecognizedObjectObservation] else { return }
            
            let detectedObjects = results.filter { $0.confidence > 0.5 }.map { observation -> DetectedObject in
                let boundingBox = observation.boundingBox
                let label = observation.labels.first?.identifier ?? "Unknown"
                let confidence = observation.confidence
                return DetectedObject(boundingBox: boundingBox, label: label, confidence: confidence)
            }
            
            DispatchQueue.main.async {
                self?.delegate?.cameraViewController(self!, didDetectObjects: detectedObjects)
            }
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }
}
