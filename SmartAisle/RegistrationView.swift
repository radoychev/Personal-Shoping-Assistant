import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @Binding var currentView: String
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                backgroundGradient
            }
            VStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Let's get you started!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 40)
                            .fontDesign(.rounded)

                        
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
                                .fontDesign(.rounded)

                        }
                        
                        if let successMessage = successMessage {
                            Text(successMessage)
                                .foregroundColor(.green)
                                .padding(.top, 10)
                                .fontDesign(.rounded)

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
                                    .fontDesign(.rounded)

                            }
                            .padding(.top, 20)
                        }
                        
                        Button(action: {
                            currentView = "LoginView"
                        }) {
                            Text("Back to Login")
                                .foregroundColor(.black)
                                .underline()
                                .padding(.top, 20)
                                .fontDesign(.rounded)

                        }
                    }
                }
                Spacer()
            }
            .padding(20)
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            currentView = "HomeView"
                        }
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                        successMessage = nil
                }
            }
        }
    }
}
