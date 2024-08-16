import SwiftUI
import FirebaseAuth

struct ChangePasswordScreen: View {
    @Binding var navigate: Screen
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    navigate = .home
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Change Password")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Spacer()
                    .frame(width: 40) // Empty spacer to balance the back button
            }
            .padding(.top, 50)
            .padding(.horizontal)

            Spacer()

            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.black)
                    SecureField("Old Password", text: $oldPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.black)
                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)

                Button(action: {
                    changePassword()
                }) {
                    Text("Confirm")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                        if alertTitle == "Password Changed" {
                            navigate = .home
                        }
                    })
                }

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
            .padding()
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)

            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    func changePassword() {
        guard let user = Auth.auth().currentUser else {
            alertTitle = "Error"
            alertMessage = "No user is currently logged in."
            showAlert = true
            return
        }

        guard let email = user.email else {
            alertTitle = "Error"
            alertMessage = "User email is not available."
            showAlert = true
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)

        user.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                alertTitle = "Error"
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                user.updatePassword(to: newPassword) { error in
                    if let error = error {
                        alertTitle = "Error"
                        alertMessage = error.localizedDescription
                        showAlert = true
                    } else {
                        alertTitle = "Password Changed"
                        alertMessage = "Your password has been successfully changed."
                        showAlert = true
                    }
                }
            }
        }
    }
}

struct ChangePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordScreen(navigate: .constant(.changePassword))
    }
}
