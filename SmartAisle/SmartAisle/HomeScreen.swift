import SwiftUI
import Firebase

struct HomeScreen: View {
    @Binding var navigate: Screen
    @EnvironmentObject var weeklyDealsManager: WeeklyDealsManager
    var username: String

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    logout()
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 50)
            .padding(.horizontal)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome \(username)!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    Text("Weekly Deals")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    if weeklyDealsManager.weeklyDeals.isEmpty {
                        Text("No weekly deals available.")
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(weeklyDealsManager.weeklyDeals) { deal in
                                VStack {
                                    if let url = URL(string: deal.productImageURL) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(10)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(10)
                                            @unknown default:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(10)
                                    }

                                    Text(deal.productName)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)

                                    Text("€\(String(format: "%.2f", deal.productPrice))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear {
            weeklyDealsManager.fetchWeeklyDeals()
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            navigate = .login
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(navigate: .constant(.home), username: "User")
            .environmentObject(WeeklyDealsManager())
    }
}
