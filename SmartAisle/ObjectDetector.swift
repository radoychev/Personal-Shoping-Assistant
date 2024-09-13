import Vision
import CoreML
import SwiftUI

class ObjectDetector: ObservableObject {
    @Published var detectedObjects: [DetectedObject] = []

    private var model: VNCoreMLModel

    init() {
        // Replace `Redbul` with the actual class name of your model
        guard let model = try? VNCoreMLModel(for: Redbul().model) else {
            print("Failed to load model")
            fatalError("App cannot function without a valid model.")
        }
        self.model = model
    }

    func detectObjects(in image: UIImage) {
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
            guard let self = self else { return }
            if let error = error {
                print("Object detection failed: \(error.localizedDescription)")
                return
            }
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                print("Unexpected result type from VNCoreMLRequest")
                return
            }
            self.processResults(results)
        }

        request.imageCropAndScaleOption = .scaleFill // Add image crop and scale option
        
        guard let ciImage = CIImage(image: image) else {
            print("Could not convert UIImage to CIImage")
            return
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        // Run in background thread for performance
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform request: \(error.localizedDescription)")
            }
        }
    }

    private func processResults(_ results: [VNRecognizedObjectObservation]) {
        DispatchQueue.main.async {
            // Filter out low confidence results
            self.detectedObjects = results.filter { $0.confidence > 0.5 }.map { result in
                let label = result.labels.first?.identifier ?? "Unknown"
                print("Detected object label: \(label) with confidence: \(result.confidence)")
                return DetectedObject(boundingBox: result.boundingBox, label: label, confidence: result.confidence)
            }
        }
    }
}

struct DetectedObject {
    let boundingBox: CGRect
    let label: String
    let confidence: VNConfidence
}
