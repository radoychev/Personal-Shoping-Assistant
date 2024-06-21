import SwiftUI
import Firebase

@main
struct SmartAisleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var shoppingListManager = ShoppingListManager()
    @StateObject private var weeklyDealsManager = WeeklyDealsManager()

    @State private var currentScreen: Screen = .welcome
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
                HomeScreen(navigate: $currentScreen, username: "User") // Default username
            case .homeScreen(let username):
                HomeScreen(navigate: $currentScreen, username: username) // Pass username
            case .homeViewModel:
                HomeViewModelPlaceholderScreen(navigate: $currentScreen) // Placeholder screen
            case .about:
                AboutScreen(navigate: $currentScreen)
            case .adminPanel:
                AdminPanelScreen(navigate: $currentScreen)
            case .changePassword:
                ChangePasswordScreen(navigate: $currentScreen)
            case .emailScreen:
                EmailScreen(navigate: $currentScreen)
            case .pairShoppingList:
                PairShoppingListScreen(navigate: $currentScreen)
            case .search:
                SearchScreen(navigate: $currentScreen, selectedProduct: $selectedProduct, searchText: $searchText, searchResults: $searchResults)
            case .settings:
                SettingsScreen(navigate: $currentScreen)
            case .productDetailScreen:
                if let product = selectedProduct {
                    ProductDetailScreen(navigate: $currentScreen, product: product)
                        .environmentObject(shoppingListManager)
                } else {
                    Text("No product selected")
                }
            case .shoppingList:
                ShoppingListScreen(navigate: $currentScreen, searchText: $searchText, searchResults: $searchResults)
            case .sharedShoppingList:
                SharedShoppingListView(navigate: $currentScreen)
            default:
                Text("Unknown screen")
            }
        }
    }
}


struct HomeViewModelPlaceholderScreen: View {
    @Binding var navigate: Screen

    var body: some View {
        VStack {
            Text("Home ViewModel Placeholder")
            Button("Go Back") {
                navigate = .home
            }
        }
    }
}
