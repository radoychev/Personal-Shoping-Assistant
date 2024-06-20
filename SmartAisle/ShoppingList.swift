import SwiftUI
import Swift
import SwiftData

struct ShoppingList: View{
    let products = ["Product 1", "Product 2", "Product 3", "Product 4", "Product 5", "Product 6", "Product 7"]
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My Shopping List")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Total: € 10:00")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                        ForEach(products, id: \.self) { product in
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.5))
                                    .frame(width: 60, height: 60)
                                
                                Text(product)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("My Shopping List", displayMode: .inline)
            }
        }
        .ignoresSafeArea()
    }
}



