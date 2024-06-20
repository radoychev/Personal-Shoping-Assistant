import SwiftUI
import Swift
import SwiftData

struct Home: View{
    let backgroundGradient = LinearGradient(
        colors: [.bg, .fg],
        startPoint: .bottomTrailing, endPoint: .top)
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome User!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.leading, 20)
                
                Section(header: Text("Weekly Deals")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.top, 20)) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                            ForEach(0..<6) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.8))
                                    .frame(height: 100)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                
                Section(header: Text("Currently Popular")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.top, 20)) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                            ForEach(0..<6) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.8))
                                    .frame(height: 100)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
            }
            Footer()
        }
        .ignoresSafeArea()
    }
}


