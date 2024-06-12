import SwiftUI

struct PairShoppingListScreen: View {
    @Binding var navigate: Screen
    @State private var email: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            VStack {
                Text("Pair Shopping List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                
                Spacer()

                VStack {
                    Text("Email Address")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    HStack {
                        Image(systemName: "at")
                            .foregroundColor(.black)
                        TextField("email@gmail.com", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(30)
                }
                .padding()
                .background(Color(red: 0.14, green: 0.48, blue: 0.63))
                .cornerRadius(10)
                .padding(.bottom, 20)

                Button(action: {
                    // Handle confirm action
                    showAlert = true
                }) {
                    Text("Confirm")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.top, 5)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Email Submitted"), message: Text("Your email has been successfully submitted."), dismissButton: .default(Text("OK")))
                }

                Button(action: {
                    navigate = .home
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(30)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding(.horizontal, 20)
            
            Footer(navigate: $navigate)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.12, green: 0.51, blue: 0.68))
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct PairShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PairShoppingListScreen(navigate: .constant(.pairShoppingList))
    }
}
