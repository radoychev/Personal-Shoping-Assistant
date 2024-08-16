import Foundation
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Forgot Password")
                .font(.title2) // Adjusted font size to fit in one line
                .fontWeight(.bold)
                .foregroundColor(.black)
                .fontDesign(.rounded)

            Spacer()
            Spacer()
                .frame(width: 40)
            
            Spacer()
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black) // Visible text color
                        .keyboardType(.emailAddress)
                        .fontDesign(.rounded)

                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    resetPassword()
                }) {
                    Text("Reset Password")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                        .fontDesign(.rounded)

                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                Button(action: {
                        // Add logic to navigate back or dismiss the view
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(30)
                        .fontDesign(.rounded)

                }
                .padding(.top, 20)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            
            Spacer()
            
        }
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertTitle = "Error"
                alertMessage = error.localizedDescription
            } else {
                alertTitle = "Success"
                alertMessage = "A password reset email has been sent to \(email)."
            }
            showAlert = true
        }
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
