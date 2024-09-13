import SwiftUI

struct Footer: View {
    @Binding var currentTab: Screen

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(tab: tab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(Color("navBarBg"))
        .padding(.bottom, getSafeArea().bottom == 0 ? 5 : getSafeArea().bottom)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    func TabButton(tab: Tab) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                currentTab = tab.screen
            }
        }) {
            VStack(spacing: 0) {
                Image(systemName: currentTab.iconName(for: tab))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                
                Text(tab.tabName)
                    .foregroundColor(.accentColor)
                    .font(.footnote)
                    .padding(.top, 1)
            }
        }
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer(currentTab: .constant(.home))
    }
}

// Navbar Enum

enum Tab: String, CaseIterable {
    case Home = "house"
    case List = "list.bullet.rectangle"
    case Catalogue = "book"
    case ARScanner = "opticid"
    case Settings = "gearshape"

    var tabName: String {
        switch self {
        case .Home:
            return "Index"
        case .List:
            return "List"
        case .Catalogue:
            return "Catalogue"
        case .ARScanner:
            return "Scanner"
        case .Settings:
            return "Settings"
        }
    }
    
    var screen: Screen {
        switch self {
        case .Home:
            return .home
        case .List:
            return .shoppingList
        case .Catalogue:
            return .search
        case .ARScanner:
            return .arViewScreen
        case .Settings:
            return .settings
        }
    }
}

extension Screen {
    func iconName(for tab: Tab) -> String {
        switch self {
        case .home where tab == .Home:
            return "house.fill"
        case .shoppingList where tab == .List:
            return "list.bullet.rectangle.fill"
        case .search where tab == .Catalogue:
            return "book.fill"
        case .pairShoppingList where tab == .ARScanner:
            return "opticid.fill"
        case .settings where tab == .Settings:
            return "gearshape.fill"
        default:
            return tab.rawValue
        }
    }
}

extension View {
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
