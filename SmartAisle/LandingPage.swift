import SwiftUI

struct LandingPage: View {
    @Binding var currentView: String
    
    var body: some View {
        ZStack{
            VStack{
                backgroundGradient
            }
            VStack{
                Text("Welcome to SmartAisle")
                    .font(.title)
                    .padding()
                    .foregroundColor(.accentColor)
                    .fontDesign(.rounded)
                    .padding(.bottom, 5)
                    .fontDesign(.rounded)

                
                Text("What would you like to do")
                    .font(.title)
                    .padding()
                    .foregroundColor(.accentColor)
                    .fontDesign(.rounded)
                HStack {
                    Spacer()
                    
                    Button(action: {
                        currentView = "LoginView"
                    }) {
                        Text("Login")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .fontDesign(.rounded)
                    }
                    
                    Button(action: {
                        currentView = "RegistrationView"
                    }) {
                        Text("Register")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .fontDesign(.rounded)

                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .ignoresSafeArea()

    }
}
