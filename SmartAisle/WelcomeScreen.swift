import SwiftUI

struct WelcomeScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Welcome Screen")
            Button("Go to Login") {
                navigate = .login
            }
        }
    }
}
