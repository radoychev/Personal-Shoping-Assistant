import SwiftUI

struct SharedShoppingListView: View {
    @EnvironmentObject var shoppingListManager: ShoppingListManager
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Shared Shopping Lists")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            sharedWithUsersView
            pendingRequestsView
            
            Spacer()
            
            Button(action: {
                navigate = .pairShoppingList
            }) {
                Text("Back")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
    
    private var sharedWithUsersView: some View {
        VStack {
            Text("Sharing With")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            if let pairedUserEmail = shoppingListManager.pairedUserEmail {
                Text("Email: \(pairedUserEmail)")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            } else {
                Text("Not sharing with anyone")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .padding()
        .background(Color(red: 0.14, green: 0.48, blue: 0.63))
        .cornerRadius(10)
        .padding(.top, 20)
    }
    
    private var pendingRequestsView: some View {
        VStack {
            Text("Pending Requests")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            ForEach(shoppingListManager.pairingRequests) { request in
                HStack {
                    Text("Request from: \(request.fromUserEmail ?? request.fromUserId)")
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        acceptRequest(request)
                    }) {
                        Text("Accept")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color(red: 0.14, green: 0.48, blue: 0.63))
        .cornerRadius(10)
        .padding(.top, 20)
    }
    
    private func acceptRequest(_ request: PairingRequest) {
        shoppingListManager.acceptPairingRequest(request) { result in
            switch result {
            case .success:
                print("Request accepted successfully")
                // Refresh the pairing requests and paired user ID
                shoppingListManager.loadPairingRequests()
                shoppingListManager.loadPairedUser()
                shoppingListManager.loadPairedShoppingList() // Add this line to reload the paired shopping list
            case .failure(let error):
                print("Error accepting request: \(error.localizedDescription)")
            }
        }
    }
}

struct SharedShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        SharedShoppingListView(navigate: .constant(.sharedShoppingList))
            .environmentObject(ShoppingListManager())
    }
}
