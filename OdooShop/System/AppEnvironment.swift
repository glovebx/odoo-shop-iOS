//
//  AppEnvironment.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/30.
//


import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandlerProtocol
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        /*
         To see the deep linking in action:
         
         1. Launch the app in iOS 13.4 simulator (or newer)
         2. Subscribe on Push Notifications with "Allow Push" button
         3. Minimize the app
         4. Drag & drop "push_with_deeplink.apns" into the Simulator window
         5. Tap on the push notification
         
         Alternatively, just copy the code below before the "return" and launch:
         
            DispatchQueue.main.async {
                deepLinksHandler.open(deepLink: .showCountryFlag(alpha3Code: "AFG"))
            }
        */
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(appState: appState,
                                                webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventsHandler = SystemEventsHandler(container: diContainer)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let authenticateWebRepository = AuthenticateWebRepository(
            session: session,
            baseURL: "http://127.0.0.1:8069")
        return .init(authenticateWebRepository: authenticateWebRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              webRepositories: DIContainer.WebRepositories
    ) -> DIContainer.Interactors {
        
        let authenticateInteractor = AuthenticateInteractor(
            webRepository: webRepositories.authenticateWebRepository,
            appState: appState)
        
        return .init(authenticateInteractor: authenticateInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let authenticateWebRepository: AuthenticateWebRepositoryProtocol
    }
}

