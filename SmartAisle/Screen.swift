import SwiftUI

enum Screen: Hashable {
    case welcome
    case login
    case registration
    case home
    case about
    case adminPanel
    case changePassword
    case emailScreen
    case pairShoppingList
    case search
    case settings
    case forgotPassword
    case productDetailScreen
    case shoppingList
    case sharedShoppingList
    case homeScreen(String)  // New case with associated value
    case homeViewModel    
    case WeeklyDealsManager// Added new case

    var iconName: String {
        switch self {
        case .welcome:
            return "house"
        case .login:
            return "person"
        case .registration:
            return "person.badge.plus"
        case .home, .homeScreen, .homeViewModel:
            return "house"
        case .about:
            return "info.circle"
        case .adminPanel, .WeeklyDealsManager:
            return "person.3"
        case .changePassword:
            return "key"
        case .forgotPassword:
            return "key.1"
        case .emailScreen:
            return "envelope"
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
        }
    }

    var tabName: String {
        switch self {
        case .welcome:
            return "Welcome"
        case .login:
            return "Login"
        case .registration:
            return "Register"
        case .home, .homeScreen,.WeeklyDealsManager, .homeViewModel:
            return "Home"
        case .about:
            return "About"
        case .forgotPassword:
            return "Forgot Password"
        case .adminPanel:
            return "Admin Panel"
        case .changePassword:
            return "Change Password"
        case .emailScreen:
            return "Email"
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
        }
    }
}
