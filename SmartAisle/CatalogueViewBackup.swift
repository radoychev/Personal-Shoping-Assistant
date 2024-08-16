//import Foundation
//import SwiftUI
//
//struct CatalogueViewBackup: View {
//    @Binding var selectedProduct: Product?
//    @Binding var searchText: String
//    @Binding var searchResults: [Product]
//    
//    @EnvironmentObject var shoppingListManager: ShoppingListManager
//    
//    var body: some View {
//        VStack {
//            
//            Text("Search")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//                .padding(.bottom, 20)
//            
//            TextField("Search...", text: $searchText, onCommit: {
//                searchProducts()
//            })
//            .padding()
//            .background(Color.white)
//            .cornerRadius(10)
//            .padding(.horizontal)
//            .padding(.bottom, 20)
//            
//            if searchResults.isEmpty && !searchText.isEmpty {
//                Text("No products found.")
//                    .font(.headline)
//                    .padding()
//            } else {
//                List {
//                    ForEach($searchResults, id: \.self) { product in
//                        HStack {
//                            if let imageUrl = product.imageInfo.primaryView.first?.url, let url = URL(string: imageUrl) {
//                                AsyncImage(url: url) { phase in
//                                    switch phase {
//                                        case .empty:
//                                            ProgressView()
//                                        case .success(let image):
//                                            image
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                                .frame(width: 50, height: 50)
//                                        case .failure:
//                                            Image(systemName: "photo")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                                .frame(width: 50, height: 50)
//                                        @unknown default:
//                                            Image(systemName: "photo")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                                .frame(width: 50, height: 50)
//                                    }
//                                }
//                            } else {
//                                Image(systemName: "photo")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                            }
//                            
//                            VStack(alignment: .leading) {
//                                NavigationLink(destination: ProductDetailsView(product: product)) {
//                                    Text(product.title)
//                                        .font(.headline)
//                                }
//                                
//                                Text("€\(String(format: "%.2f", product.prices.price.amount / 100))")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
//                            
//                            Button(action: {
//                                shoppingListManager.addToShoppingList(product)
//                            }) {
//                                Image(systemName: "plus.circle.fill")
//                                    .font(.title)
//                                    .foregroundColor(.green)
//                            }
//                            .buttonStyle(BorderlessButtonStyle())
//                        }
//                    }
//                }
//            }
//            
//            Spacer()
//        }
//    }
//    
//    func searchProducts() {
//        NetworkManager.shared.searchProducts(query: searchText) { result in
//            switch result {
//                case .success(let products):
//                    DispatchQueue.main.async {
//                        print("Retrieved products: \(products)") //debugging
//                        self.searchResults = products
//                    }
//                case .failure(let error):
//                    print("Error searching products: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    private var headers: [String: String] {
//        return [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer your_api_key"
//        ]
//    }
//}
//
//struct Catalogue_Previews: PreviewProvider {
//    static var previews: some View {
//        CatalogueViewBackup(selectedProduct: .constant(nil), searchText: .constant(""), searchResults: .constant([]))
//            .environmentObject(ShoppingListManager())
//    }
//}
