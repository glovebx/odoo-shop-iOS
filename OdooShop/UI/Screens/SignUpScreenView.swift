//
//  SignUpScreenView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI

struct SignUpScreenView: View {
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        Text("Hello \(injected.appState[\.userData.user].name), Under Construction!")
    }
}

struct SignUpScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreenView()
    }
}
