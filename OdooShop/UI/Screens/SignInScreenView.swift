//
//  SignInScreenView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI

struct SignInScreenView: View {
    
    @State private(set) var versionInfo: Loadable<ServerVersionData>
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var url: String = ""
    @State private var database: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    init(versionInfo: Loadable<ServerVersionData> = .notRequested) {
        self._versionInfo = .init(initialValue: versionInfo)
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
                    
                    switch(versionInfo) {
                    case let .loaded(versionInfo):
                        Text(versionInfo.result.serverVersion)
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
                    
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.bottom)
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .textContentType(.password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.bottom)
                    
                    PrimaryButton(title: "Login")
                        .padding(.top, 20)
                        .onTapGesture {
                            // do login
                            //                            SignUpScreenView()
                            injected.interactors
                                .authenticateInteractor
                                .loadServerVersion(versionInfo: $versionInfo)
                        }
                    
                }
                
                Spacer()
                
                Divider()
                
                Spacer()
            }
        }
        .padding()
    }
}

//struct SignInScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInScreenView()
//    }
//}
