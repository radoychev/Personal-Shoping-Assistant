import SwiftUI

struct ProductDetailScreen: View {
    @Binding var navigate: Screen
    let product: Product

    @StateObject private var viewModel = ProductDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let productDetails = viewModel.productDetails {
                    ProductImageView(imageUrl: productDetails.imageInfo.primaryView.first?.url)
                    ProductInfoView(productDetails: productDetails)
                    AddToCartButton()
                    ProductDescriptionView(description: productDetails.description)
                    ProductIngredientsView(ingredients: productDetails.ingredients)
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                        .onAppear {
                            viewModel.fetchProductDetails(productID: product.id)
                        }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationBarTitle(Text(product.title), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                navigate = .search
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
            })
        }
        .onAppear {
            viewModel.fetchProductDetails(productID: product.id)
        }
    }
}

struct ProductImageView: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 300)
        }
    }
}

struct ProductInfoView: View {
    let productDetails: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(productDetails.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)

            Text("€\(String(format: "%.2f", productDetails.prices.price.amount / 100))")
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Text(productDetails.quantity)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
    }
}

struct AddToCartButton: View {
    var body: some View {
        Button(action: {
            // Add to cart action
        }) {
            Text("Add to cart")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
}

struct ProductDescriptionView: View {
    let description: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Product Description:")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal)

            if let description = description {
                Text(description)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            } else {
                Text("No description available.")
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
        }
    }
}

struct ProductIngredientsView: View {
    let ingredients: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients:")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal)

            if let ingredients = ingredients {
                Text(ingredients)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
        }
    }
}

class ProductDetailViewModel: ObservableObject {
    @Published var productDetails: Product? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    func fetchProductDetails(productID: String) {
        isLoading = true
        NetworkManager.shared.getProductDetails(productID: productID) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let productDetails):
                    print("Product details fetched successfully")
                    self.productDetails = productDetails
                case .failure(let error):
                    print("Error fetching product details: \(error.localizedDescription)")
                    self.errorMessage = "Error fetching product details: \(error.localizedDescription)"
                }
            }
        }
    }
}

// Preview
struct ProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample product for preview
        let sampleProduct = Product(
            id: "1",
            title: "Sample Product",
            prices: Prices(price: Price(amount: 999)),
            imageInfo: ImageInfo(primaryView: [ImageView(url: "https://via.placeholder.com/150")]),
            quantity: "2kg",
            description: "This is a sample product description.",
            ingredients: "Semi-skimmed milk"
        )

        NavigationView {
            ProductDetailScreen(navigate: .constant(.search), product: sampleProduct)
        }
    }
}
