import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()

    private init() {} // Prevents instantiation from outside

    func register(email: String, password: String, username: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                let changeRequest = authResult.user.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        Firestore.firestore().collection("users").document(authResult.user.uid).setData([
                            "email": email,
                            "username": username,
                            "created_at": Timestamp(date: Date())
                        ]) { error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                completion(.success(authResult))
                            }
                        }
                    }
                }
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
}
