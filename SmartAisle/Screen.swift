import SwiftUI

enum Screen: String {
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

    var iconName: String {
        switch self {
        case .welcome:
            return "house"
        case .login:
            return "person"
        case .registration:
            return "person.badge.plus"
        case .home:
            return "house"
        case .about:
            return "info.circle"
        case .adminPanel:
            return "person.3"
        case .changePassword:
            return "key"
        case .emailScreen:
            return "envelope"
        case .pairShoppingList:
            return "list.bullet.rectangle"
        case .search:
            return "magnifyingglass"
        case .settings:
            return "gearshape"
        }
    }

    var tabName: String {
        switch self {
        case .welcome:
            return "Welcome"
        case .login:
            return "Login"
        case .registration:
            return "AR Search"
        case .home:
            return "Home"
        case .about:
            return "About"
        case .adminPanel:
            return "Admin Panel"
        case .changePassword:
            return "Change Password"
        case .emailScreen:
            return "Email"
        case .pairShoppingList:
            return "List"
        case .search:
            return "Search"
        case .settings:
            return "Settings"
        }
    }
}
