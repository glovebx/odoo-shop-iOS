//
//  AuthenticateInteractor.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/30.
//

import Foundation
import Combine

protocol AuthenticateInteractorProtocol {
    func loadServerVersion(versionInfo: LoadableSubject<ServerVersionData>)
}

struct AuthenticateInteractor: AuthenticateInteractorProtocol {
    let webRepository: AuthenticateWebRepositoryProtocol
    let appState: Store<AppState>
    
    init(webRepository: AuthenticateWebRepositoryProtocol, appState: Store<AppState>) {
        self.webRepository = webRepository
        self.appState = appState
    }
    
    func loadServerVersion(versionInfo: LoadableSubject<ServerVersionData>) {
        let cancelBag = CancelBag()
        versionInfo.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        return webRepository
            .loadServerVersion()
            .sinkToLoadable {
                versionInfo.wrappedValue = $0
            }
        // 保存到数据库
            .store(in: cancelBag)
    }
}

struct StubAuthenticateInteractor: AuthenticateInteractorProtocol {
    
    func loadServerVersion(versionInfo: LoadableSubject<ServerVersionData>) {
    }
}
