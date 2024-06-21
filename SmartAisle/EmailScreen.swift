import Foundation

import SwiftUI

struct EmailScreen: View {
    @Binding var navigate: Screen
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("This page is for testing")
                .font(.largeTitle)
                .padding()
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        scale = 1.2
                    }
                }
            
            Spacer()
            
            Text("Email Screen")
                .font(.title)
                .padding()
            
            Button("Go to Home") {
                navigate = .home
            }
            .padding()
        }
    }
}


