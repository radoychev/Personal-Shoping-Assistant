import SwiftUI

struct ChangePasswordScreen: View {
    @Binding var navigate: Screen
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.12, green: 0.51, blue: 0.68)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Text("Change Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 40)

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
                        }
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.black)
                            SecureField("New Password", text: $newPassword)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal)
                    }

                    Button(action: {
                        // Handle password change
                        showAlert = true
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
                        Alert(title: Text("Password Changed"), message: Text("Your password has been successfully changed."), dismissButton: .default(Text("OK")))
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

                    Spacer()
                }
                .padding(20)
            )
    }
}

struct ChangePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordScreen(navigate: .constant(.changePassword))
    }
}
