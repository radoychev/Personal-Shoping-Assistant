import SwiftUI

struct RegistrationScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Registration Screen")
            Button("Go to Login") {
                navigate = .login
            }
        }
    }
}
