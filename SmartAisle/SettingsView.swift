import SwiftUI
import Firebase

struct SettingsView: View {
    @Binding var currentView: String
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    backgroundGradient
                }
                VStack {
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.gray)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Change Password")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                    }
                    .padding()
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.gray)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Pair Shopping Lists")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                    }
                    HStack {
                        NavigationLink(destination: About()) {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.gray)
                                .frame(width: 225, height: 75)
                                .overlay(
                                    Text("About")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                )
                        }
                    }
                    .padding()
                    
                    HStack {
                        Button(action: {
                            logout()
                        }) {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.redBox)
                                .frame(width: 225, height: 75)
                                .overlay(
                                    Text("Logout")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                )
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            currentView = "LandingPage"
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SettingsView(currentView: .constant("SettingsView"))
}
