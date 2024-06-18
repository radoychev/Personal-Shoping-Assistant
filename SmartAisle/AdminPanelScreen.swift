import SwiftUI

struct AdminPanelScreen: View {
    @Binding var navigate: Screen
    @State private var item: Item = Item(number: "", price: "", quantity: "")
    @State private var newItem: Item = Item(number: "", price: "", quantity: "")

    struct Item {
        var number: String
        var price: String
        var quantity: String
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        navigate = .home
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Admin Panel")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Spacer()
                        .frame(width: 40)
                }
                .padding(.top, geometry.safeAreaInsets.top + 10) // Dynamic padding based on safe area
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 20) {  // Reduced the spacing to minimize height
                    VStack {
                        Text("Edit Products")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)

                        TextField("Item #", text: $item.number)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        TextField("Price", text: $item.price)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        TextField("Quantity", text: $item.quantity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        HStack {
                            Button(action: {
                                handleDelete()
                            }) {
                                Text("Delete")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                handleSave()
                            }) {
                                Text("Save")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .frame(maxWidth: 400)  // Limiting the width

                    VStack {
                        Text("Add Products")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)

                        TextField("Item #", text: $newItem.number)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        TextField("Price", text: $newItem.price)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        TextField("Quantity", text: $newItem.quantity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)

                        Button(action: {
                            handleAdd()
                        }) {
                            Text("Add")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .frame(maxWidth: 400)  // Limiting the width
                }
                .padding(.horizontal)

                Spacer()

                Footer(navigate: $navigate)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.12, green: 0.51, blue: 0.68))
                    .edgesIgnoringSafeArea(.bottom)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.53, green: 0.81, blue: 0.92)]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }

    private func handleDelete() {
        print("Deleting item number:", item.number)
    }

    private func handleSave() {
        print("Saving:", item)
    }

    private func handleAdd() {
        print("Adding:", newItem)
    }
}

struct AdminPanelScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelScreen(navigate: .constant(.adminPanel))
    }
}
