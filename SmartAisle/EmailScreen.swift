import Foundation

import SwiftUI

struct EmailScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Email Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
