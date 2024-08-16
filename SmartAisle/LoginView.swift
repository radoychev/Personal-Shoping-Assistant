import SwiftUI
import Firebase

struct LoginView: View {
    @Binding var currentView: String
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                backgroundGradient
            }
            VStack {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 40)
                    .fontDesign(.rounded)

                
                VStack(spacing: 20) {
                    CustomTextField(systemImageName: "envelope", placeholder: "Email", text: $email, isSecure: false)
                    CustomTextField(systemImageName: "lock", placeholder: "Password", text: $password, isSecure: true)
                }
                .foregroundColor(.black)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                        .fontDesign(.rounded)

                }
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .fontDesign(.rounded)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
                
                Button(action: {
                    ForgotPasswordView()
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.black)
                        .underline()
                        .padding(.top, 10)
                }
            }
            .padding(20)
            .onChange(of: navigateToHome) { newValue in
                if newValue {
                    currentView = "HomeView"
                }
            }
        }
        .ignoresSafeArea()
    }
        
    func login(){
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let user):
                        if let currentUser = Auth.auth().currentUser {
                            navigateToHome = true
                        }
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                }
            }
        }
    }
}


