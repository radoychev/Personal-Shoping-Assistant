import SwiftUI

struct ARViewScreen: View {
    @Binding var navigate: Screen
    @Binding var searchText: String
    @State private var detectedObjects: [DetectedObject] = []

    var body: some View {
        ZStack {
            CameraView(detectedObjects: $detectedObjects)
                .edgesIgnoringSafeArea(.all)

            ForEach(detectedObjects, id: \.label) { object in
                GeometryReader { geometry in
                    let boundingBox = self.convertBoundingBox(object.boundingBox, in: geometry.size)
                    ZStack(alignment: .topLeading) {
                        // Bounding Box
                        Rectangle()
                            .path(in: boundingBox)
                            .stroke(Color.green, lineWidth: 2)

                        // AR-style Label
                        VStack(alignment: .leading) {
                            Text(object.label)
                                .font(.headline)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                            
                            Text("Confidence: \(String(format: "%.2f", object.confidence))")
                                .font(.subheadline)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        .padding(4)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(5)
                        .offset(x: boundingBox.minX, y: boundingBox.minY - 30) // Offset to position label above the bounding box
                    }
                }
                .onTapGesture {
                    // Trigger a search with the detected object's label
                    self.searchText = object.label
                    self.navigate = .search
                }
            }

            VStack {
                Spacer()
                Button(action: {
                    navigate = .home
                }) {
                    Text("Back to Home")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
        }
    }

    func convertBoundingBox(_ boundingBox: CGRect, in size: CGSize) -> CGRect {
        let origin = CGPoint(x: boundingBox.minX * size.width, y: (1 - boundingBox.maxY) * size.height)
        let dimensions = CGSize(width: boundingBox.width * size.width, height: boundingBox.height * size.height)
        return CGRect(origin: origin, size: dimensions)
    }
}

struct ARViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ARViewScreen(navigate: .constant(.home), searchText: .constant(""))
    }
}
