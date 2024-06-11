import SwiftUI

struct AboutScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("About Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
