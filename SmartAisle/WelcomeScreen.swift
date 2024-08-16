import SwiftUI

struct WelcomeScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 0.53, green: 0.81, blue: 0.92), Color(red: 0.53, green: 0.82, blue: 0.98)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("Do you have a SmartAisle account?")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            navigate = .login
                        }) {
                            Text("Yes")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.53, green: 0.81, blue: 0.92))
                                .padding()
                                .frame(width: 100)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            navigate = .registration
                        }) {
                            Text("No")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.53, green: 0.81, blue: 0.92))
                                .padding()
                                .frame(width: 100)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                }
            )
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(navigate: .constant(.welcome))
    }
}
