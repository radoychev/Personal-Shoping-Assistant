import SwiftUI

struct Footer: View {
    @Binding var navigate: Screen
    @State var currentScreen: Screen = .home
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach([Screen.home, Screen.shoppingList, Screen.registration, Screen.search, Screen.settings], id: \.self) { screen in
                TabButton(screen: screen)
            }
        }
        .padding(.vertical, 10)
        .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 10))
        .background(Color.blue) // Use any color you prefer
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func TabButton(screen: Screen) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                currentScreen = screen
                navigate = screen
            }
        }, label: {
            VStack(spacing: 5) {
                Image(systemName: currentScreen == screen ? selectedIconName(for: screen) : iconName(for: screen))
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.white)
                
                Text(screen.tabName)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
        })
    }
    
    func iconName(for screen: Screen) -> String {
        switch screen {
        case .registration:
            return "arkit"
        default:
            return screen.iconName
        }
    }
    
    func selectedIconName(for screen: Screen) -> String {
        switch screen {
        case .registration:
            return "arkit"
        case .search:
            return "magnifyingglass" // No fill version available
        default:
            return screen.iconName + ".fill"
        }
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer(navigate: .constant(.home))
    }
}
