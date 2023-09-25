// ThreadsApp.swift
// Threads
//
//

import SwiftUI
import FirebaseCore

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Configura Firebase.
    FirebaseApp.configure()

    return true
  }
}

// MARK: - ThreadsApp

@main
struct ThreadsApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
