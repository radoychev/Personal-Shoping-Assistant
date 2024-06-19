import Foundation
import FirebaseFirestore
import FirebaseAuth

class ShoppingListManager: ObservableObject {
    @Published var shoppingList: [Product] = []
    @Published var pairedShoppingList: [Product] = []
    @Published var mergedShoppingList: [Product] = []
    @Published var pairingRequests: [PairingRequest] = []
    @Published var pairedUserId: String?
    @Published var pairedUserEmail: String?

    private var db = Firestore.firestore()
    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let user = user {
                self?.loadShoppingList()
                self?.loadPairedShoppingList()
                self?.loadPairingRequests()
                self?.loadPairedUser()
            } else {
                self?.clearData()
            }
        }
    }
    
    private func clearData() {
        shoppingList = []
        pairedShoppingList = []
        mergedShoppingList = []
        pairingRequests = []
        pairedUserId = nil
        pairedUserEmail = nil
    }

    func addToShoppingList(_ product: Product) {
        guard !shoppingList.contains(where: { $0.id == product.id }) else { return }
        shoppingList.append(product)
        saveShoppingList()
        mergeShoppingLists()
    }

    func removeFromShoppingList(_ product: Product) {
        if let index = shoppingList.firstIndex(where: { $0.id == product.id }) {
            shoppingList.remove(at: index)
        } else if let index = pairedShoppingList.firstIndex(where: { $0.id == product.id }) {
            pairedShoppingList.remove(at: index)
        }
        saveShoppingList()
        mergeShoppingLists()
    }

    private func saveShoppingList() {
        guard let userId = userId else {
            print("No user is currently logged in.")
            return
        }

        let userDocRef = db.collection("users").document(userId)
        do {
            let encodedList = try shoppingList.map { try JSONEncoder().encode($0) }
            let stringList = encodedList.map { $0.base64EncodedString() }
            userDocRef.setData(["shoppingList": stringList], merge: true) { error in
                if let error = error {
                    print("Error saving shopping list: \(error.localizedDescription)")
                } else {
                    print("Shopping list successfully saved.")
                }
            }
        } catch {
            print("Error encoding shopping list: \(error.localizedDescription)")
        }
    }

    func loadShoppingList() {
        guard let userId = userId else {
            print("No user is currently logged in.")
            return
        }
        
        let userDocRef = db.collection("users").document(userId)
        userDocRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error loading shopping list: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(), let stringList = data["shoppingList"] as? [String] else {
                print("Document does not exist or does not contain shopping list")
                return
            }
            do {
                self?.shoppingList = try stringList.map {
                    guard let decodedData = Data(base64Encoded: $0) else {
                        throw NSError(domain: "Invalid base64 string", code: -1, userInfo: nil)
                    }
                    return try JSONDecoder().decode(Product.self, from: decodedData)
                }
                self?.mergeShoppingLists()
            } catch {
                print("Error decoding shopping list: \(error.localizedDescription)")
            }
        }
    }

    func loadPairedShoppingList() {
        guard let userId = userId, let pairedUserId = pairedUserId else {
            print("No user is currently logged in or paired user not found.")
            return
        }

        let userDocRef = db.collection("users").document(pairedUserId)
        userDocRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error loading paired shopping list: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(), let stringList = data["shoppingList"] as? [String] else {
                print("Document does not exist or does not contain paired shopping list")
                return
            }
            do {
                self?.pairedShoppingList = try stringList.map {
                    guard let decodedData = Data(base64Encoded: $0) else {
                        throw NSError(domain: "Invalid base64 string", code: -1, userInfo: nil)
                    }
                    return try JSONDecoder().decode(Product.self, from: decodedData)
                }
                self?.mergeShoppingLists()
            } catch {
                print("Error decoding paired shopping list: \(error.localizedDescription)")
            }
        }
    }

    private func mergeShoppingLists() {
        mergedShoppingList = shoppingList + pairedShoppingList
    }

    func pairWithUser(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { [weak self] querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = querySnapshot?.documents, let document = documents.first else {
                completion(.failure(NSError(domain: "No user found with the given email", code: -1, userInfo: nil)))
                return
            }
            let pairedWithUID = document.documentID
            self?.sendPairingRequest(toUserId: pairedWithUID, completion: completion)
        }
    }

    private func sendPairingRequest(toUserId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let fromUserId = userId else {
            completion(.failure(NSError(domain: "No user is currently logged in", code: -1, userInfo: nil)))
            return
        }

        let requestId = UUID().uuidString
        let request = PairingRequest(id: requestId, fromUserId: fromUserId, toUserId: toUserId, status: "pending", fromUserEmail: nil)

        do {
            let requestData = try Firestore.Encoder().encode(request)
            db.collection("pairingRequests").document(requestId).setData(requestData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func loadPairingRequests() {
        guard let userId = userId else {
            print("No user is currently logged in.")
            return
        }

        db.collection("pairingRequests").whereField("toUserId", isEqualTo: userId).whereField("status", isEqualTo: "pending").addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print("Error loading pairing requests: \(error.localizedDescription)")
                return
            }

            let requests = snapshot?.documents.compactMap { document in
                try? document.data(as: PairingRequest.self)
            } ?? []

            let userIds = requests.map { $0.fromUserId }
            self?.fetchEmails(for: userIds) { emails in
                self?.pairingRequests = requests.map { request in
                    var request = request
                    request.fromUserEmail = emails[request.fromUserId] ?? request.fromUserId
                    return request
                }
            }
        }
    }

    func loadPairedUser() {
        guard let userId = userId else {
            print("No user is currently logged in.")
            return
        }

        let userDocRef = db.collection("users").document(userId)
        userDocRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error loading paired user: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(), let pairedWithUID = data["pairedWith"] as? String else {
                self?.pairedUserId = nil
                self?.pairedUserEmail = nil
                return
            }
            self?.pairedUserId = pairedWithUID
            self?.fetchUserEmail(for: pairedWithUID)
        }
    }

    private func fetchUserEmail(for uid: String) {
        let userDocRef = db.collection("users").document(uid)
        userDocRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching email for user \(uid): \(error.localizedDescription)")
                self?.pairedUserEmail = nil
                return
            }
            guard let document = document, document.exists, let data = document.data(), let email = data["email"] as? String else {
                self?.pairedUserEmail = nil
                return
            }
            self?.pairedUserEmail = email
        }
    }

    func fetchEmails(for userIds: [String], completion: @escaping ([String: String]) -> Void) {
        var emails = [String: String]()
        let group = DispatchGroup()
        
        for userId in userIds {
            group.enter()
            db.collection("users").document(userId).getDocument { document, error in
                if let error = error {
                    print("Error fetching email for user \(userId): \(error.localizedDescription)")
                }
                if let document = document, document.exists, let data = document.data(), let email = data["email"] as? String {
                    emails[userId] = email
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(emails)
        }
    }

    func acceptPairingRequest(_ request: PairingRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("pairingRequests").document(request.id).updateData(["status": "accepted"]) { [weak self] error in
            if let error = error {
                completion(.failure(error))
                return
            }

            self?.db.collection("users").document(request.fromUserId).setData(["pairedWith": request.toUserId], merge: true) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                self?.db.collection("users").document(request.toUserId).setData(["pairedWith": request.fromUserId], merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    self?.mergeShoppingLists(fromUserId: request.fromUserId, toUserId: request.toUserId)
                    completion(.success(()))
                }
            }
        }
    }

    private func mergeShoppingLists(fromUserId: String, toUserId: String) {
        let userDocRef = db.collection("users").document(fromUserId)
        userDocRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error loading shopping list for user \(fromUserId): \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(), let fromStringList = data["shoppingList"] as? [String] else {
                print("No shopping list found for user \(fromUserId)")
                return
            }
            
            let toUserDocRef = self?.db.collection("users").document(toUserId)
            toUserDocRef?.getDocument { document, error in
                if let error = error {
                    print("Error loading shopping list for user \(toUserId): \(error.localizedDescription)")
                    return
                }
                guard let document = document, document.exists, let data = document.data(), let toStringList = data["shoppingList"] as? [String] else {
                    print("No shopping list found for user \(toUserId)")
                    return
                }
                
                var mergedShoppingList: [Product] = []
                do {
                    let fromProducts = try fromStringList.map {
                        guard let decodedData = Data(base64Encoded: $0) else {
                            throw NSError(domain: "Invalid base64 string", code: -1, userInfo: nil)
                        }
                        return try JSONDecoder().decode(Product.self, from: decodedData)
                    }
                    let toProducts = try toStringList.map {
                        guard let decodedData = Data(base64Encoded: $0) else {
                            throw NSError(domain: "Invalid base64 string", code: -1, userInfo: nil)
                        }
                        return try JSONDecoder().decode(Product.self, from: decodedData)
                    }
                    
                    mergedShoppingList = fromProducts + toProducts
                } catch {
                    print("Error merging shopping lists: \(error.localizedDescription)")
                    return
                }
                
                do {
                    let encodedList = try mergedShoppingList.map { try JSONEncoder().encode($0) }
                    let stringList = encodedList.map { $0.base64EncodedString() }
                    self?.db.collection("sharedLists").document("\(fromUserId)_\(toUserId)").setData(["shoppingList": stringList], merge: true) { error in
                        if let error = error {
                            print("Error saving merged shopping list: \(error.localizedDescription)")
                        } else {
                            print("Merged shopping list successfully saved.")
                        }
                    }
                } catch {
                    print("Error encoding merged shopping list: \(error.localizedDescription)")
                }
            }
        }
    }
}
