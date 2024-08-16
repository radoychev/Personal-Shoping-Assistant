import UIKit
import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let initialViewController: UIViewController
        
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            initialViewController = UIHostingController(rootView: HomeScreen(navigate: .constant(.home), username: "User").environmentObject(WeeklyDealsManager()))
        } else {
            initialViewController = UIHostingController(rootView: LoginScreen(navigate: .constant(.login)))
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
 
