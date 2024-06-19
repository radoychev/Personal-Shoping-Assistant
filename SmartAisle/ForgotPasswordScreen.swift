//
//  ForgotPasswordScreen.swift
//  SmartAisle
//
//  Created by Md Kaiser Aftab on 11/06/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ForgotPasswordScreen: View {
    @Binding var navigate: Screen
    @State private var email: String = ""
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
                Text("Forgot Password")
                    .font(.title2) // Adjusted font size to fit in one line
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                // Empty spacer to balance the back button
                Spacer()
                    .frame(width: 40)
            }
            .padding(.top, 50)
            .padding(.horizontal)

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
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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

            Footer(navigate: $navigate)
                .frame(maxWidth: .infinity, maxHeight: 80)
                .background(Color(red: 0.12, green: 0.51, blue: 0.68))
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
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
        ForgotPasswordScreen(navigate: .constant(.forgotPassword))
    }
}
