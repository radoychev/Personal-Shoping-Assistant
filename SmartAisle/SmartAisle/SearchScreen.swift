import SwiftUI

struct SearchScreen: View {
    @Binding var navigate: Screen
    @Binding var selectedProduct: Product?
    @Binding var searchText: String
    @Binding var searchResults: [Product]

    @EnvironmentObject var shoppingListManager: ShoppingListManager
    @State private var showAlert = false // Add this state variable
    @State private var alertMessage = "" // State to hold the alert message

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    navigate = .home
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal)

            Text("Search")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)

            TextField("Search...", text: $searchText, onCommit: {
                searchProducts()
            })
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 20)

            if searchResults.isEmpty && !searchText.isEmpty {
                Text("No products found.")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(searchResults) { product in
                        HStack {
                            if let imageUrl = product.imageInfo?.primaryView.first?.url, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    @unknown default:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }

                            VStack(alignment: .leading) {
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    Text(product.title)
                                        .font(.headline)
                                }

                                if let amount = product.prices?.price.amount {
                                    Text("€\(String(format: "%.2f", amount / 100))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()

                            Button(action: {
                                shoppingListManager.addToShoppingList(product)
                                alertMessage = "\(product.title) has been added to your shopping list!"
                                showAlert = true // Trigger the alert
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.green)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Item Added"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    func searchProducts() {
        NetworkManager.shared.searchProducts(query: searchText) { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    print("Retrieved products: \(products)") //debugging
                    self.searchResults = products
                }
            case .failure(let error):
                print("Error searching products: \(error.localizedDescription)")
            }
        }
    }
}
