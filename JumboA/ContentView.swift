import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search products...", text: $searchText, onCommit: {
                        self.networkManager.resetAndFetch(query: self.searchText)
                    })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    Button(action: {
                        self.networkManager.resetAndFetch(query: self.searchText)
                    }) {
                        Text("Search")
                    }
                    .padding(.trailing)
                }
                .padding()
                
                if networkManager.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = networkManager.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if networkManager.products.isEmpty {
                    Text("No products found")
                        .padding()
                } else {
                    List(networkManager.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            Text(product.title)
                        }
                        .onAppear {
                            if self.networkManager.products.last == product {
                                self.networkManager.fetchData(query: self.searchText.isEmpty ? nil : self.searchText)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Products")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
