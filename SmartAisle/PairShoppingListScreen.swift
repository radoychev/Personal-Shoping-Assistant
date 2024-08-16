import SwiftUI

struct PairShoppingListScreen: View {
    @Binding var navigate: Screen
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @EnvironmentObject var shoppingListManager: ShoppingListManager

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
            }
            .padding(.top, 50)
            .padding(.horizontal)
            
            Text("Pair Shopping List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            emailInputView
            confirmButton
            sharedListsButton
            cancelButton
            Spacer() // Ensure the spacer pushes the content up and the footer down
        }
        .padding(.horizontal, 20)
        .background(backgroundGradient)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private var emailInputView: some View {
        VStack {
            Text("Email Address")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 10)

            HStack {
                Image(systemName: "at")
                    .foregroundColor(.black)
                TextField("email@gmail.com", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .accessibility(label: Text("Email Address"))
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
        }
        .padding()
        .background(Color(red: 0.14, green: 0.48, blue: 0.63))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }

    private var confirmButton: some View {
        Button(action: pairShoppingList) {
            Text("Confirm")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
        }
        .padding(.top, 5)
    }

    private var cancelButton: some View {
        Button(action: {
            navigate = .home
        }) {
            Text("Cancel")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(30)
        }
        .padding(.top, 20)
    }

    private var sharedListsButton: some View {
        Button(action: {
            navigate = .sharedShoppingList
        }) {
            Text("View Shared Lists")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(30)
        }
        .padding(.top, 20)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private func pairShoppingList() {
        shoppingListManager.pairWithUser(email: email) { result in
            switch result {
            case .success:
                alertTitle = "Success"
                alertMessage = "Pairing request sent."
            case .failure(let error):
                alertTitle = "Error"
                alertMessage = error.localizedDescription
            }
            showAlert = true
        }
    }
}

struct PairShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PairShoppingListScreen(navigate: .constant(.pairShoppingList))
            .environmentObject(ShoppingListManager())
    }
}
