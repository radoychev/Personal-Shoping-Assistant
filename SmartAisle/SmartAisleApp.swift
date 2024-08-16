import SwiftUI
import Firebase

@main
struct SmartAisleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var weeklyDealsManager = WeeklyDealsManager()
    @State private var currentView: String = "LandingPage"
    
    

    var body: some Scene {
        WindowGroup {
            Group {
                switch currentView {
                    case "LandingPage":
                        LandingPage(currentView: $currentView)
                    case "LoginView":
                        LoginView(currentView: $currentView)
                    case "RegistrationView":
                        RegistrationView(currentView: $currentView)
                    case "HomeView":
                        NavigationView {
                            Footer(currentView: $currentView)
                        }
                    default:
                        LandingPage(currentView: $currentView)
                }
            }
            .onAppear {
                checkAuthState()
            }
        }
    }
    private func checkAuthState() {
        if Auth.auth().currentUser != nil {
                // User is signed in, navigate to HomeView
            currentView = "HomeView"
        } else {
                // No user is signed in, navigate to LandingPage
            currentView = "LandingPage"
        }
    }
}
