//
//  SystemEventsHandler.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import UIKit
import Combine

protocol SystemEventsHandlerProtocol {
    func sceneDidBecomeActive()
    func sceneWillResignActive()
}

struct SystemEventsHandler: SystemEventsHandlerProtocol {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
        
    func sceneDidBecomeActive() {
        container.appState[\.system.isActive] = true
    }
    
    func sceneWillResignActive() {
        container.appState[\.system.isActive] = false
    }
    
}
