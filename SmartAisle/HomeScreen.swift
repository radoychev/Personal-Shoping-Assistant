import SwiftUI

struct HomeScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Home Screen")
            Button("Go to Settings") {
                navigate = .settings
            }
        }
    }
}
