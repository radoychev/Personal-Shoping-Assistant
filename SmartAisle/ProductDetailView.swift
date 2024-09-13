import SwiftUI

struct ProductDetailView: View {
    let product: Product

    @State private var productDetails: Product? = nil
    @EnvironmentObject var shoppingListManager: ShoppingListManager
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            if let productDetails = productDetails {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Product Image
                        if let imageUrl = productDetails.imageInfo?.primaryView.first?.url, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                @unknown default:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }

                        // Product Title
                        Text(productDetails.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding([.top, .horizontal])

                        // Product Quantity
                        if let quantity = productDetails.quantity {
                            Text(quantity)
                                .font(.headline)
                                .padding(.horizontal)
                        }

                        // Product Price
                        if let amount = productDetails.prices?.price.amount {
                            Text("€\(String(format: "%.2f", amount / 100))")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding([.horizontal, .bottom])
                        }

                        // Add to Shopping List Button
                        Button(action: {
                            addToShoppingList(productDetails)
                        }) {
                            Text("Add to Shopping List")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }

                        // Product Description
                        Text("Product Description")
                            .font(.headline)
                            .padding([.top, .horizontal])

                        Text(productDetails.description ?? "No description available.")
                            .padding([.horizontal, .bottom])

                        // Product Ingredients
                        if let ingredients = productDetails.ingredients {
                            Text("Ingredients")
                                .font(.headline)
                                .padding([.top, .horizontal])

                            Text(ingredients)
                                .padding([.horizontal, .bottom])
                        }
                    }
                }
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        fetchProductDetails()
                    }
            }
        }
        .navigationBarTitle(Text(product.title), displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Item Added"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func fetchProductDetails() {
        NetworkManager.shared.getProductDetails(productID: product.id) { result in
            switch result {
            case .success(let fetchedProductDetails):
                DispatchQueue.main.async {
                    self.productDetails = fetchedProductDetails
                }
            case .failure(let error):
                print("Error fetching product details: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to load product details. Please try again later."
                    self.showAlert = true
                }
            }
        }
    }

    func addToShoppingList(_ product: Product) {
        if shoppingListManager.shoppingList.contains(where: { $0.id == product.id }) {
            alertMessage = "\(product.title) is already in your shopping list!"
        } else {
            shoppingListManager.addToShoppingList(product)
            alertMessage = "\(product.title) has been added to your shopping list!"
        }
        showAlert = true
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = Product(
            id: "1",
            title: "Sample Product",
            prices: Prices(price: Price(amount: 999)),
            imageInfo: ImageInfo(primaryView: [ImageView(url: "https://via.placeholder.com/150")]),
            quantity: "2kg",
            description: "This is a sample product description.",
            ingredients: "Sample ingredients"
        )
        ProductDetailView(product: sampleProduct)
            .environmentObject(ShoppingListManager()) // Ensure to add the environment object for the preview
    }
}
