import SwiftUI

struct HomeView: View {
    
    //@EnvironmentObject let weeklyDealsManager: WeeklyDealsManager
    //let  username: String
    // UNCOMMENT ABOVE ONCE DB CONNECTED //
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let username = "John Doe"
    
    var body: some View {
        ZStack {
            VStack {
                backgroundGradient
            }
            VStack(spacing: 0) {
                HStack{
                    Text("Home")
                        .font(.title)
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .ignoresSafeArea()
                }
                .padding(.top, 50)
                .padding(.horizontal, 25)
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome \(username)!")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 50)
                            .padding(.horizontal, 25)
                        
                        Text("Weekly Deals")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .padding(.top, 50)
                            .padding(.horizontal, 25)
                        
                            //                        if weeklyDealsManager.weeklyDeals.isEmpty {
                            //                            Text("No weekly deals available.")
                            //                                .foregroundColor(.gray)
                            //                                .padding(.bottom, 20)
                            //                        }else {
                            //                        LazyVGrid(columns: columns, spacing: 20) {
                            //                            ForEach(weeklyDealsManager.weeklyDeals) { deal in
                            //                                VStack {
                            //                                    if let url = URL(string: deal.productImageURL) {
                            //                                        AsyncImage(url: url) { phase in
                            //                                            switch phase {
                            //                                                case .empty:
                            //                                                    ProgressView()
                            //                                                case .success(let image):
                            //                                                    image
                            //                                                        .resizable()
                            //                                                        .aspectRatio(contentMode: .fit)
                            //                                                        .frame(width: 60, height: 60)
                            //                                                        .cornerRadius(10)
                            //                                                case .failure:
                            //                                                    Image(systemName: "photo")
                            //                                                        .resizable()
                            //                                                        .aspectRatio(contentMode: .fit)
                            //                                                        .frame(width: 60, height: 60)
                            //                                                        .cornerRadius(10)
                            //                                                @unknown default:
                            //                                                    Image(systemName: "photo")
                            //                                                        .resizable()
                            //                                                        .aspectRatio(contentMode: .fit)
                            //                                                        .frame(width: 60, height: 60)
                            //                                                        .cornerRadius(10)
                            //                                            }
                            //                                        }
                            //                                    } else {
                            //                                        Image(systemName: "photo")
                            //                                            .resizable()
                            //                                            .aspectRatio(contentMode: .fit)
                            //                                            .frame(width: 60, height: 60)
                            //                                            .cornerRadius(10)
                            //                                    }
                            //
                            //                                    Text(deal.productName)
                            //                                        .font(.caption)
                            //                                        .multilineTextAlignment(.center)
                            //                                        .lineLimit(2)
                            //
                            //                                    Text("€\(String(format: "%.2f", deal.productPrice))")
                            //                                        .font(.caption)
                            //                                        .foregroundColor(.gray)
                            //                                }
                            //                                .padding()
                            //                                .background(Color.white)
                            //                                .cornerRadius(10)
                            //                                .shadow(radius: 2)
                            //                    }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
