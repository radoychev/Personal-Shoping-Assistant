import SwiftUI

struct SearchScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Search Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
