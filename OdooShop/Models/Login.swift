//
//  Login.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/31.
//

import Foundation

struct Login: Equatable {
    let serverUrl: String
    let database: String
    let username: String
    let password: String

    init(serverUrl: String, database: String, username: String, password: String) {
        self.serverUrl = serverUrl
        self.database = database
        self.username = username
        self.password = password
    }
}
