import SwiftUI

struct PairShoppingListScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Pair Shopping List Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
