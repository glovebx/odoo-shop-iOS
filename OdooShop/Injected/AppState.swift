//
//  AppState.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userContext = UserContext()
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
//    var permissions = Permissions()
}

extension AppState {
    struct UserContext: Equatable {
        var serverVersion: String = ""
    }
}

extension AppState {
    struct UserData: Equatable {
        var user: User = .init()
//        var sessionId: String = ""
    }
}

extension AppState {
    struct ViewRouting: Equatable {
//        var countriesList = CountriesList.Routing()
//        var countryDetails = CountryDetails.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

//extension AppState {
//    struct Permissions: Equatable {
//        var push: Permission.Status = .unknown
//    }
//
//    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
//        let pathToPermissions = \AppState.permissions
//        switch permission {
//        case .pushNotifications:
//            return pathToPermissions.appending(path: \.push)
//        }
//    }
//}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system
//    && lhs.permissions == rhs.permissions
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
