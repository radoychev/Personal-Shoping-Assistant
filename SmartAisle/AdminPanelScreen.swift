import SwiftUI
import Firebase
import FirebaseFirestore

struct AdminPanelScreen: View {
    @Binding var navigate: Screen
    @State private var searchText: String = ""
    @State private var searchResults: [Product] = []
    @State private var weeklyDeals: [WeeklyDeal] = []
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false

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
                Text("Admin Panel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                Spacer()
                Spacer()
                    .frame(width: 40)
            }
            .padding(.top, 10)
            .padding(.horizontal)

            SearchBar(text: $searchText, onSearchButtonClicked: searchProducts)
                .padding(.bottom, 10)

            if isLoading {
                ProgressView("Loading products...")
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Search Results")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(searchResults) { product in
                            HStack {
                                Text(product.title)
                                Spacer()
                                Button(action: {
                                    addProductToDeals(product: product)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.title)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
            }

            Text("Weekly Deals")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.horizontal)

            ScrollView {
                ForEach(weeklyDeals) { deal in
                    HStack {
                        if let url = URL(string: deal.productImageURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(deal.productName)
                                .font(.headline)
                            Text("€\(deal.productPrice, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()

            Button(action: {
                saveWeeklyDeals()
            }) {
                Text("Save Deals")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.53, green: 0.81, blue: 0.92)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    private func searchProducts() {
        isLoading = true
        NetworkManager.shared.searchProducts(query: searchText, offset: 0, limit: 10) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let products):
                    self.searchResults = products
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func addProductToDeals(product: Product) {
        let deal = WeeklyDeal(
            id: product.id,
            productName: product.title,
            productPrice: product.prices.price.amount / 100.0, // assuming price is in cents
            productImageURL: product.imageInfo.primaryView.first?.url ?? ""
        )
        if !weeklyDeals.contains(where: { $0.id == deal.id }) {
            weeklyDeals.append(deal)
        }
    }

    private func saveWeeklyDeals() {
        let db = Firestore.firestore()
        for deal in weeklyDeals {
            do {
                let _ = try db.collection("weeklyDeals").document(deal.id).setData(from: deal)
            } catch let error {
                print("Error writing deal to Firestore: \(error)")
                self.errorMessage = "Error saving deals: \(error.localizedDescription)"
            }
        }
        self.errorMessage = "Deals successfully saved!"
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var onSearchButtonClicked: () -> Void

        init(text: Binding<String>, onSearchButtonClicked: @escaping () -> Void) {
            _text = text
            self.onSearchButtonClicked = onSearchButtonClicked
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onSearchButtonClicked()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, onSearchButtonClicked: onSearchButtonClicked)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct AdminPanelScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelScreen(navigate: .constant(.adminPanel))
    }
}
