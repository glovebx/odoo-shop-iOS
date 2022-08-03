//
//  ContentView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        WelcomeScreenView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().inject(.preview)
    }
}

struct PrimaryButton: View {
    var title: String
    var enabled: Bool
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(enabled ? .white : .gray)
            .frame(maxWidth: .infinity)
            .padding()
            .background(enabled ? Color("PrimaryColor") : Color.white)
            .cornerRadius(50)
            .allowsHitTesting(enabled)
    }
}
