import SwiftUI

struct AdminPanelScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Admin Panel Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
