import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: SecondView()) {
                Text("Go to Second View")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Home")
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is the second view")
            .navigationTitle("Second View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
