import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    backgroundGradient
                }
                VStack{
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                            //NavigationLink(destination: ChangePasswordScreen()){
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Change Password")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                            //}
                    }
                    .padding()
                    
                    HStack {
                            //NavigationLink(destination: PairShoppingListScreen()){
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Pair Shopping Lists")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                            //}
                    }
                    HStack {
                        NavigationLink(destination: About()){
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.box)
                                .frame(width: 225, height: 75)
                                .overlay(
                                    Text("About")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                )
                        }
                    }
                    .padding()
                    
                    HStack {
                        //NavigationLink(destination: About()){
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.redBox)
                                .frame(width: 225, height: 75)
                                .overlay(
                                    Text("Logout")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                            )
                        //}
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
}
