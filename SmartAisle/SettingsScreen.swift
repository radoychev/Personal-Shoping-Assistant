import SwiftUI
import FirebaseAuth

struct SettingsScreen: View {
    @Binding var navigate: Screen
    @State private var showAdminPasswordPrompt = false
    @State private var adminPassword: String = ""
    @State private var showAdminError: Bool = false

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

            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    navigate = .changePassword
                }) {
                    Text("Change Password")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    showAdminPasswordPrompt.toggle()
                }) {
                    Text("Admin Panel")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    navigate = .pairShoppingList
                }) {
                    Text("Pair Shopping Lists")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    navigate = .about
                }) {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    logout()
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
            }
            .padding(.top, 100)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Footer(navigate: $navigate)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.12, green: 0.51, blue: 0.68))
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .sheet(isPresented: $showAdminPasswordPrompt) {
            AdminPasswordPrompt(adminPassword: $adminPassword, showAdminPasswordPrompt: $showAdminPasswordPrompt, authenticateAdminPassword: authenticateAdminPassword)
        }
        .alert(isPresented: $showAdminError) {
            Alert(title: Text("Error"), message: Text("Incorrect admin password."), dismissButton: .default(Text("OK")))
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            navigate = .login
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    private func authenticateAdminPassword() {
        let correctAdminPassword = "admin123" // Replace with your actual admin password
        if adminPassword == correctAdminPassword {
            navigate = .adminPanel
        } else {
            showAdminError = true
        }
        adminPassword = ""
    }
}

struct AdminPasswordPrompt: View {
    @Binding var adminPassword: String
    @Binding var showAdminPasswordPrompt: Bool
    var authenticateAdminPassword: () -> Void

    var body: some View {
        VStack {
            Text("Enter Admin Password")
                .font(.headline)
                .padding()

            SecureField("Password", text: $adminPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

            HStack {
                Button("Cancel") {
                    showAdminPasswordPrompt = false
                }
                .padding()
                
                Spacer()
                
                Button("Submit") {
                    showAdminPasswordPrompt = false
                    authenticateAdminPassword()
                }
                .padding()
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(navigate: .constant(.settings))
    }
}
