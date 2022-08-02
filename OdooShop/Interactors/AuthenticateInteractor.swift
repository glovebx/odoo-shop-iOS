//
//  AuthenticateInteractor.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/30.
//

import Foundation
import Combine

protocol AuthenticateInteractorProtocol {
    func authenticate(login: Login, userResult: LoadableSubject<UserResult>)
}

struct AuthenticateInteractor: AuthenticateInteractorProtocol {
    let webRepository: AuthenticateWebRepositoryProtocol
    let appState: Store<AppState>
    
    init(webRepository: AuthenticateWebRepositoryProtocol, appState: Store<AppState>) {
        self.webRepository = webRepository
        self.appState = appState
    }
    
    func authenticate(login: Login, userResult: LoadableSubject<UserResult>) {
        let cancelBag = CancelBag()
        userResult.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        var cookie: String = ""
        weak var weakAppState = appState
        webRepository
            .loadServerVersion(login: login)
            .flatMap{ _ -> AnyPublisher<DbResult, Error> in
                return webRepository.listDatabase(login: login)
            }
            .flatMap{ dbResult -> AnyPublisher<UserResult, Error> in
                let login: Login = .init(serverUrl: login.serverUrl,
                                         database: dbResult.result.first ?? "",
                                         username: login.username,
                                         password: login.password)
                return webRepository.authenticate(login: login) {
                    cookie = $0
                }
            }
            .sinkToLoadable {
                dump($0)
                userResult.wrappedValue = $0
                if var user = $0.value?.result {
                    if user.uid > 0 {
                        user.sessionId = cookie
                    }
                    
                    weakAppState?[\.userData.user] = user
                } else {
                    weakAppState?[\.userData.user] = .init()
                }                
            }
        // TODO: 保存到数据库
            .store(in: cancelBag)
    }
}

struct StubAuthenticateInteractor: AuthenticateInteractorProtocol {
    
    func authenticate(login: Login, userResult: LoadableSubject<UserResult>) {
    }
}
