import SwiftUI
struct SplashScreen: View {
    @State private var isActive = false
    @State private var textOpacity = 0.0

    var body: some View {
        VStack {
            if isActive {
                ContentView()
            } else {
                VStack {
                    Text("SMARTAISLE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Your personal shopping assistant")
                        .font(.title2)
                        .foregroundColor(.black)
                        .opacity(textOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                self.textOpacity = 1.0
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 173/255, green: 216/255, blue: 230/255))
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
