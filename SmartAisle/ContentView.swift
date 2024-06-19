import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var searchText: String = ""
    @State private var currentPage: Int = 0
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for products", text: $searchText, onCommit: {
                    searchProducts(reset: true)
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

                if isLoading && products.isEmpty {
                    ProgressView("Loading products...")
                } else {
                    List {
                        ForEach(products) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                HStack {
                                    if let imageUrl = product.imageInfo.primaryView.first?.url, let url = URL(string: imageUrl) {
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
                                        Text(product.title)
                                            .font(.headline)

                                        Text("€\(String(format: "%.2f", product.prices.price.amount / 100))")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            }
                        }

                        if isLoading {
                            ProgressView()
                                .padding()
                        } else {
                            Button(action: {
                                loadMoreProducts()
                            }) {
                                Text("Load More")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationBarTitle("Supermarket Search")
        }
    }

    func searchProducts(reset: Bool = false) {
        if reset {
            currentPage = 0
            products.removeAll()
        }
        loadMoreProducts()
    }

    func loadMoreProducts() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        NetworkManager.shared.searchProducts(query: searchText, offset: currentPage * 30, limit: 30) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let newProducts):
                    self.products.append(contentsOf: newProducts)
                    self.currentPage += 1
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
