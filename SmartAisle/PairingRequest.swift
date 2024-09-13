import Foundation

struct PairingRequest: Identifiable, Codable {
    var id: String
    var fromUserId: String
    var toUserId: String
    var status: String
    var fromUserEmail: String? // Ensure this property is included

    init(id: String, fromUserId: String, toUserId: String, status: String, fromUserEmail: String? = nil) {
        self.id = id
        self.fromUserId = fromUserId
        self.toUserId = toUserId
        self.status = status
        self.fromUserEmail = fromUserEmail
    }
}
