//
//  InteractorsContainer.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/30.
//

extension DIContainer {
    struct Interactors {
        let authenticateInteractor: AuthenticateInteractorProtocol
        
        init(authenticateInteractor: AuthenticateInteractorProtocol) {
            self.authenticateInteractor = authenticateInteractor
        }
        
        static var stub: Self {
            .init(authenticateInteractor: StubAuthenticateInteractor())
        }
    }
}
