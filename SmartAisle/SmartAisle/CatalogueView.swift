import SwiftUI

struct CatalogueView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    backgroundGradient
                }
                VStack{
                    HStack {
                        NavigationLink(destination: ProductDetailsView()){
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.box)
                                .frame(width: 225, height: 75)
                                .overlay(
                                    Text("Placeholder")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                )
                        }
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    CatalogueView()
}
