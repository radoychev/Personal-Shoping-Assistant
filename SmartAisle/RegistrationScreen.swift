import SwiftUI
import FirebaseAuth

struct RegistrationScreen: View {
    @Binding var navigate: Screen
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Let's get you started!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 40)

                        VStack(spacing: 20) {
                            CustomTextField(systemImageName: "person", placeholder: "Username", text: $username, isSecure: false)
                            CustomTextField(systemImageName: "envelope", placeholder: "Email", text: $email, isSecure: false)
                            CustomTextField(systemImageName: "lock", placeholder: "Password", text: $password, isSecure: true)
                        }
                        .padding(.horizontal, 20)

                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                        }
                        
                        if let successMessage = successMessage {
                            Text(successMessage)
                                .foregroundColor(.green)
                                .padding(.top, 10)
                        }

                        if isLoading {
                            ProgressView()
                                .padding(.top, 20)
                        } else {
                            Button(action: {
                                register()
                            }) {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                        }

                        Button(action: {
                            navigate = .login
                        }) {
                            Text("Back to Login")
                                .foregroundColor(.black)
                                .underline()
                                .padding(.top, 20)
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle("Register", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                navigate = .welcome
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            })
        }
    }
    
    func register() {
        isLoading = true
        AuthService.shared.register(email: email, password: password, username: username) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(_):
                    successMessage = "Registration Successful"
                    errorMessage = nil
                    // Optional: Navigate to a different screen after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigate = .emailScreen
                    }
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    successMessage = nil
                }
            }
        }
    }
}


struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen(navigate: .constant(.registration))
    }
}
