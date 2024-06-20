import SwiftUI

struct AboutScreen: View {
    @Binding var navigate: Screen

    var body: some View {
        VStack {
            Text("About")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)

            Spacer()

            VStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                    .padding(.bottom, 40)

                Text("Application Version")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("1.0.0")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)

                Text("Copyright")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("NHL Stenden Hogeschool - 2024")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)

                Text("Security Version")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("1.0.0")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .padding(.top, 20)

            Spacer()

            Footer(navigate: $navigate)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.12, green: 0.51, blue: 0.68))
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen(navigate: .constant(.about))
    }
}
