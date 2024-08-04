//
//  SmartAisleApp.swift
//  SmartAisle
//
//  Created by Nathan Pete on 06/06/2024.
//

import SwiftUI
 import SwiftData
 import FirebaseCore
 
 class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication,
 
 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
 FirebaseApp.configure()
 return true
 }
 }
 
 @main
 struct SmartAisleApp: App {
 var sharedModelContainer: ModelContainer = {
 
 let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
 
 do {
 return try ModelContainer(configurations: modelConfiguration)
 } catch {
 fatalError("Could not create ModelContainer: \(error)")
 }
 }()
 
 @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
 var body: some Scene {
 WindowGroup {
 NavigationView {
 
 Index()
 
 }
 }
 .modelContainer(sharedModelContainer)
 }
 }
 
