import SwiftUI

struct Footer: View {
    @Binding var currentView: String
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Spacer()
                switch selectedTab {
                    case .home:
                        HomeView()
                    case .shoppingList:
                        ShoppingList()
                    case .catalogue:
                        Catalogue(selectedProduct: .constant(nil), searchText: .constant(""), searchResults: .constant([]))
                    case .scanner:
                        ScannerView()
                    case .settings:
                        SettingsView(currentView: $currentView) 
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            customTabBar
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var customTabBar: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                VStack {
                    Button(action: {
                        selectedTab = tab
                    }) {
                        VStack {
                            Image(systemName: selectedTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                            Text(tab.tabName)
                                .font(.footnote)
                                .fontDesign(.rounded)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.bottom)
        .background(Color("navBarBg"))
    }
}

#Preview {
    Footer(currentView: .constant("SettingsView"))
}

enum Tab: String, CaseIterable {
    case home = "house"
    case shoppingList = "list.bullet.rectangle"
    case catalogue = "book"
    case scanner = "opticid"
    case settings = "gearshape"
    
    var tabName: String {
        switch self {
            case .home:
                return "Home"
            case .shoppingList:
                return "List"
            case .catalogue:
                return "Catalogue"
            case .scanner:
                return "Scanner"
            case .settings:
                return "Settings"
        }
    }
}
