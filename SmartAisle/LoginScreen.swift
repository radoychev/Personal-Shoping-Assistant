import SwiftUI
import Firebase

struct LoginScreen: View {
    @Binding var navigate: Screen
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Text("Welcome Back!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 40)

                        VStack(spacing: 20) {
                            CustomTextField(systemImageName: "envelope", placeholder: "Email", text: $email, isSecure: false)
                            CustomTextField(systemImageName: "lock", placeholder: "Password", text: $password, isSecure: true)
                        }

                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                        }

                        Button(action: {
                            login()
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 20)

                        Button(action: {
                            navigate = .forgotPassword
                        }) {
                            Text("Forgot Password?")
                                .foregroundColor(.black)
                                .underline()
                                .padding(.top, 10)
                        }

                        Button(action: {
                            navigate = .registration
                        }) {
                            Text("Create an Account")
                                .foregroundColor(.black)
                                .underline()
                                .padding(.top, 10)
                        }
                    }
                    .padding(20)
                )
                .navigationBarTitle("Login", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    navigate = .home
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                })
        }
    }

    func login() {
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    // Fetch the current user and get the display name
                    if let currentUser = Auth.auth().currentUser {
                        navigate = .homeScreen(currentUser.displayName ?? "User")
                    }
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct CustomTextField: View {
    let systemImageName: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundColor(.black)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(navigate: .constant(.login))
    }
}
