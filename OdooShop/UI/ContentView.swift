//
//  ContentView.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/29.
//

import SwiftUI

struct ContentView: View {
    private let container: DIContainer
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        WelcomeScreenView()
            .inject(container)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}
