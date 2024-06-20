import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var weeklyDeals: [Product] = []
    @Published var errorMessage: String? = nil

    private let db = Firestore.firestore()

    init() {
        fetchWeeklyDeals()
    }

    func fetchWeeklyDeals() {
        print("Fetching weekly deals...")
        db.collection("weeklyDeals").document("current").getDocument { document, error in
            if let document = document, document.exists {
                if let dealsData = document.data()?["deals"] as? [String] {
                    print("Deals data fetched: \(dealsData)")
                    self.fetchProducts(for: dealsData)
                } else {
                    self.errorMessage = "No deals available."
                    print("No deals data found in document.")
                }
            } else {
                self.errorMessage = "Error fetching deals: \(error?.localizedDescription ?? "Unknown error")"
                print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    private func fetchProducts(for productIDs: [String]) {
        var products: [Product] = []
        let group = DispatchGroup()

        for productID in productIDs {
            group.enter()
            db.collection("products").document(productID).getDocument { document, error in
                if let document = document, document.exists {
                    do {
                        if let product = try document.data(as: Product?.self) {
                            products.append(product)
                            print("Product fetched: \(product.title)")
                        }
                    } catch {
                        print("Error decoding product: \(error.localizedDescription)")
                    }
                } else {
                    print("Product document does not exist: \(productID)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.weeklyDeals = products
            print("Weekly deals updated: \(self.weeklyDeals)")
        }
    }
}
