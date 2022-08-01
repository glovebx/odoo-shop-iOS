//
//  OdooShopApp.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import CoreData
import SwiftUI

@main
struct OdooShopApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    let environment = AppEnvironment.bootstrap()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // ref: https://stackoverflow.com/questions/62840571/not-receiving-scenephase-changes
            .onChange(of: scenePhase) {(newScenePhase) in
                switch newScenePhase {
                case .active:
                    // The scene is in the foreground and interactive.
                    environment.systemEventsHandler.sceneDidBecomeActive()
                    break
                case .inactive:
                    // The scene is in the foreground but should pause its work.
                    break
                case .background:
                    // The scene isn’t currently visible in the UI.
                    environment.systemEventsHandler.sceneWillResignActive()
                    break
                @unknown default:
                    break
                }
            }
            .inject(environment.container)
        }
    }
}
