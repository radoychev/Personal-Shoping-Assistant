import SwiftUI
import Firebase

@main
struct SmartAisleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var shoppingListManager = ShoppingListManager()
    @StateObject private var weeklyDealsManager = WeeklyDealsManager()

    @State private var currentScreen: Screen = UserDefaults.standard.bool(forKey: "isLoggedIn") ? .home : .welcome
    @State private var selectedProduct: Product?
    @State private var searchText: String = ""
    @State private var searchResults: [Product] = []

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(
                    currentScreen: $currentScreen,
                    selectedProduct: $selectedProduct,
                    searchText: $searchText,
                    searchResults: $searchResults
                )
                .environmentObject(shoppingListManager)
                .environmentObject(weeklyDealsManager)
            }
        }
    }
}

struct MainView: View {
    @Binding var currentScreen: Screen
    @Binding var selectedProduct: Product?
    @Binding var searchText: String
    @Binding var searchResults: [Product]
    
    @EnvironmentObject var shoppingListManager: ShoppingListManager
    @EnvironmentObject var weeklyDealsManager: WeeklyDealsManager
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch currentScreen {
                case .welcome:
                    WelcomeScreen(navigate: $currentScreen)
                case .login:
                    LoginScreen(navigate: $currentScreen)
                case .registration:
                    RegistrationScreen(navigate: $currentScreen)
                case .forgotPassword:
                    ForgotPasswordScreen(navigate: $currentScreen)
                case .home:
                    HomeScreen(navigate: $currentScreen, username: "User")
                case .homeScreen(let username):
                    HomeScreen(navigate: $currentScreen, username: username)
                case .about:
                    AboutScreen(navigate: $currentScreen)
                case .adminPanel:
                    AdminPanelScreen(navigate: $currentScreen)
                case .changePassword:
                    ChangePasswordScreen(navigate: $currentScreen)
                case .pairShoppingList:
                    PairShoppingListScreen(navigate: $currentScreen)
                case .search:
                    SearchScreen(navigate: $currentScreen, selectedProduct: $selectedProduct, searchText: $searchText, searchResults: $searchResults)
                case .settings:
                    SettingsScreen(navigate: $currentScreen)
                case .productDetailScreen:
                    if let product = selectedProduct {
                        ProductDetailView(product: product)
                            .environmentObject(shoppingListManager)
                    } else {
                        Text("No product selected")
                    }
                case .shoppingList:
                    ShoppingListScreen(navigate: $currentScreen, searchText: $searchText, searchResults: $searchResults)
                case .sharedShoppingList:
                    SharedShoppingListView(navigate: $currentScreen)
                case .arViewScreen:
                    ARViewScreen(navigate: $currentScreen, searchText: $searchText)
                }
                if currentScreen != .welcome &&
                    currentScreen != .login &&
                    currentScreen != .registration &&
                    currentScreen != .forgotPassword {
                    Footer(currentTab: $currentScreen)
                        .frame(maxWidth: .infinity, maxHeight: 80)
                        .background(Color("navBarBg"))
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}
