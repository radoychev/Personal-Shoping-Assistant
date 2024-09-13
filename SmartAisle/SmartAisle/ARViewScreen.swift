import SwiftUI

struct ARViewScreen: View {
    @Binding var navigate: Screen
    @Binding var searchText: String
    @State private var detectedObjects: [DetectedObject] = []

    @EnvironmentObject var shoppingListManager: ShoppingListManager

    var body: some View {
        ZStack {
            CameraView(detectedObjects: $detectedObjects)
                .edgesIgnoringSafeArea(.all)

            ForEach(detectedObjects, id: \.label) { object in
                GeometryReader { geometry in
                    let boundingBox = self.convertBoundingBox(object.boundingBox, in: geometry.size)
                    ZStack(alignment: .topLeading) {
                        // Change bounding box color based on whether the object is in the shopping list
                        Rectangle()
                            .path(in: boundingBox)
                            .stroke(isInShoppingList(object.label) ? Color.green : Color.red, lineWidth: 3) // Swapped the colors

                        // AR-style Label
                        VStack(alignment: .leading) {
                            Text(object.label)
                                .font(.headline)
                                .padding(4)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                            
                            Text("Confidence: \(String(format: "%.2f", object.confidence))")
                                .font(.subheadline)
                                .padding(4)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                            
                            if isInShoppingList(object.label) {
                                Text("In Shopping List")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.green.opacity(0.75)) // Green background when in the shopping list
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(4)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(5)
                        .offset(x: boundingBox.minX, y: max(boundingBox.minY - 40, 0)) // Adjust offset
                    }
                    .position(x: boundingBox.midX, y: boundingBox.minY - 20)
                }
                .onTapGesture {
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

    private func isInShoppingList(_ label: String) -> Bool {
        let normalizedLabel = normalize(label)
        return shoppingListManager.mergedShoppingList.contains { product in
            let normalizedProductTitle = normalize(product.title)
            return normalizedProductTitle.contains(normalizedLabel) || normalizedLabel.contains(normalizedProductTitle)
        }
    }

    private func normalize(_ string: String) -> String {
        return string.lowercased().replacingOccurrences(of: " ", with: "")
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
            .environmentObject(ShoppingListManager())
    }
}
