//
//  SignInScreenView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI
import Combine

struct SignInScreenView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private(set) var userResult: Loadable<UserResult>
    
    @State private(set) var currentUser: User = .init()
    
    @State private var url: String = ""
    @State private var database: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    
    init(userResult: Loadable<UserResult> = .notRequested) {
        self._userResult = .init(initialValue: userResult)
    }
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    switch(userResult) {
                    case let .loaded(userResult):
                        Text(userResult.result?.name ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                    case .notRequested:
                        EmptyView()
                    case .isLoading(last: let last, cancelBag: let cancelBag):
                        EmptyView()
                    case .failed(_):
                        EmptyView()
                    }
                    
                    TextField("Server Url", text: $url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom)
                    
                    TextField("Login", text: $login)
                        .autocapitalization(.none)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.bottom)
                    
                    TextField("Password", text: $password)
                        .autocapitalization(.none)
                        .textContentType(.password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.bottom)
                    
                    PrimaryButton(title: "Login",
                                  enabled: !url.isEmpty && !login.isEmpty && !password.isEmpty)
                        .padding(.top, 20)
                        .onTapGesture {
                            self.authenticate(login: .init(serverUrl: url,
                                                           database: database,
                                                           username: login,
                                                           password: password))
                        }
                    
                }
                
                Spacer()
                
                Divider()
                
                Spacer()
            }
        }
        .padding()
        .onReceive(userUpdate) {
            self.currentUser = $0
            dump(injected.appState[\.userData.user])
        }
    }
}


// MARK: - State Updates

private extension SignInScreenView {

    var userUpdate: AnyPublisher<User, Never> {
        injected.appState.updates(for: \.userData.user)
    }
}


// MARK: - Side Effects

private extension SignInScreenView {
    func authenticate(login: Login) {
        injected.interactors
            .authenticateInteractor
            .authenticate(login: login, userResult: self.$userResult)
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}
