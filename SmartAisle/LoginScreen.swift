import SwiftUI

struct LoginScreen: View {
    @Binding var navigate: Screen
    @State private var email: String = ""
    @State private var password: String = ""

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
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.black)
                                TextField("email@gmail.com", text: $email)
                                    .foregroundColor(.black) // Ensure input text color is black
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            }
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(30)

                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.black)
                                SecureField("********", text: $password)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            }
                            .padding(.horizontal)
                            .frame(height: 50) // Ensure the same height as login button
                            .background(Color.white)
                            .cornerRadius(30)
                        }

                        Button(action: {
                            navigate = .home
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50) 
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                        .padding(.top, 20)

                        Button(action: {
                            navigate = .changePassword
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
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(navigate: .constant(.login))
    }
}
