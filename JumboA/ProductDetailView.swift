import SwiftUI

struct ProductDetailView: View {
    var product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(product.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let url = URL(string: product.imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                    case .failure:
                        Image(systemName: "xmark.octagon.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(product.title), displayMode: .inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "1", title: "Sample Product", imageURL: "https://example.com/image.jpg"))
    }
}
