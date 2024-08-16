import SwiftUI

/// Enumeration representing the different screens in the SmartAisleApp
enum Screen: Hashable {
    // Auth Screens
    case welcome
    case login
    case registration
    case forgotPassword
    
    // Home Screens
    case home
    case homeScreen(String)  // Home with associated value
    
    // Other Screens
    case about
    case adminPanel
    case changePassword
    case pairShoppingList
    case search
    case settings
    case productDetailScreen(Product)  // Product Detail with associated Product
    case shoppingList
    case sharedShoppingList
    case arViewScreen  // New ARView screen

    /// Returns the corresponding icon name for each screen
    var iconName: String {
        switch self {
        case .welcome:
            return "house"
        case .login:
            return "person"
        case .registration:
            return "person.badge.plus"
        case .home, .homeScreen:
            return "house"
        case .about:
            return "info.circle"
        case .adminPanel:
            return "person.3"
        case .changePassword:
            return "key"
        case .forgotPassword:
            return "key.1"
        case .pairShoppingList:
            return "list.bullet.rectangle"
        case .search:
            return "magnifyingglass"
        case .settings:
            return "gearshape"
        case .productDetailScreen:
            return "cart"
        case .shoppingList:
            return "cart.fill"
        case .sharedShoppingList:
            return "person.2.fill"
        case .arViewScreen:
            return "arkit"  // Example icon for AR view, you can customize this
        }
    }

    /// Returns the corresponding tab name for each screen
    var tabName: String {
        switch self {
        case .welcome:
            return "Welcome"
        case .login:
            return "Login"
        case .registration:
            return "Register"
        case .home, .homeScreen:
            return "Home"
        case .about:
            return "About"
        case .forgotPassword:
            return "Forgot Password"
        case .adminPanel:
            return "Admin Panel"
        case .changePassword:
            return "Change Password"
        case .pairShoppingList:
            return "Pair List"
        case .search:
            return "Search"
        case .settings:
            return "Settings"
        case .productDetailScreen:
            return "Product Detail"
        case .shoppingList:
            return "List"
        case .sharedShoppingList:
            return "Shared Lists"
        case .arViewScreen:
            return "AR View"  // Tab name for the AR view screen
        }
    }
}
