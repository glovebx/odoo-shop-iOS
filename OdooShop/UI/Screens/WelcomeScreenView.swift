//
//  WelcomeScreenView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI

struct WelcomeScreenView: View {
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image(uiImage: #imageLiteral(resourceName: "LoginIcon"))
                    Spacer()
//                    PrimaryButton(title: "Sign In")

                    NavigationLink(
                        destination: SignInScreenView(),
//                            .navigationBarHidden(true),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
//                                .padding(.vertical)
                        })
//                    .navigationBarHidden(true)
                    
                    NavigationLink(
                        destination: SignUpScreenView(),
                        //.navigationBarHidden(true),
                        label: {
                            Text("Sign Up")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
//                    .navigationBarHidden(true)
                    
                    HStack {
                        Text("Terms of Service")
                            .font(.caption2)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
