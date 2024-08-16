import SwiftUI

struct ShoppingListScreen: View {
    @Binding var navigate: Screen
    @Binding var searchText: String
    @Binding var searchResults: [Product]
    @EnvironmentObject var shoppingListManager: ShoppingListManager

    var body: some View {
        VStack {
            headerView
            productListView
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            shoppingListManager.loadShoppingList()
            shoppingListManager.loadPairedShoppingList()
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: {
                navigate = .search
            }) {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Shopping List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Spacer()
            Button(action: {
                navigate = .search
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            }
        }
        .padding(.top, 50)
        .padding(.horizontal)
    }

    private var productListView: some View {
        List {
            ForEach(shoppingListManager.mergedShoppingList.indices, id: \.self) { index in
                productRow(index: index, product: shoppingListManager.mergedShoppingList[index])
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("")
        .navigationBarHidden(true)
    }

    private func productRow(index: Int, product: Product) -> some View {
        HStack {
            Button(action: {
                shoppingListManager.toggleDone(for: product)
            }) {
                Image(systemName: product.isDone ? "checkmark.square.fill" : "square")
                    .foregroundColor(product.isDone ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8)

            Text("\(index + 1).")
                .font(.headline)
                .padding(.trailing, 8)

            if let imageUrl = product.imageInfo?.primaryView.first?.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 8)
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 8)
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 8)
            }

            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .strikethrough(product.isDone, color: .gray) // Strike-through if done

                if let amount = product.prices?.price.amount {
                    Text("€\(String(format: "%.2f", amount / 100))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .strikethrough(product.isDone, color: .gray) // Strike-through if done
                }
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }

    private func toggleDone(for index: Int) {
        shoppingListManager.mergedShoppingList[index].isDone.toggle()
        shoppingListManager.saveShoppingList() // Save the updated state
    }

    private func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            let product = shoppingListManager.mergedShoppingList[index]
            shoppingListManager.removeFromShoppingList(product)
        }
    }
}

struct ShoppingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListScreen(navigate: .constant(.shoppingList), searchText: .constant(""), searchResults: .constant([]))
            .environmentObject(ShoppingListManager())
    }
}
