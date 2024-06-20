import Foundation
import FirebaseFirestore

struct WeeklyDeal: Codable, Identifiable {
    var id: String
    var productName: String
    var productPrice: Double
    var productImageURL: String
}

class WeeklyDealsManager: ObservableObject {
    @Published var weeklyDeals: [WeeklyDeal] = []
    private var db = Firestore.firestore()

    func fetchWeeklyDeals() {
        db.collection("weeklyDeals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.weeklyDeals = documents.compactMap { queryDocumentSnapshot -> WeeklyDeal? in
                return try? queryDocumentSnapshot.data(as: WeeklyDeal.self)
            }
        }
    }

    func addWeeklyDeal(_ deal: WeeklyDeal) {
        do {
            let _ = try db.collection("weeklyDeals").document(deal.id).setData(from: deal)
        } catch let error {
            print("Error writing deal to Firestore: \(error)")
        }
    }
}
