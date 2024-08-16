import Vision
import CoreML
import SwiftUI

class ObjectDetector: ObservableObject {
    @Published var detectedObjects: [DetectedObject] = []

    private var model: VNCoreMLModel

    init() {
        // Replace `YourModel` with the actual class name of your model
        guard let model = try? VNCoreMLModel(for: Redbul().model) else {
            fatalError("Failed to load model")
        }
        self.model = model
    }

    func detectObjects(in image: UIImage) {
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                fatalError("Unexpected result type from VNCoreMLRequest")
            }
            self.processResults(results)
        }

        guard let ciImage = CIImage(image: image) else {
            fatalError("Could not convert UIImage to CIImage")
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])
    }

    private func processResults(_ results: [VNRecognizedObjectObservation]) {
        DispatchQueue.main.async {
            self.detectedObjects = results.map { result in
                DetectedObject(boundingBox: result.boundingBox, label: result.labels.first?.identifier ?? "Unknown", confidence: result.confidence)
            }
        }
    }
}

struct DetectedObject {
    let boundingBox: CGRect
    let label: String
    let confidence: VNConfidence
}
