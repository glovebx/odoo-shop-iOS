//
//  User.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/31.
//

import Foundation

struct User: Decodable, Equatable {
//    let serverUrl: String
    let db: String
    let uid: Int
    let username: String
    let name: String
    var sessionId: String = ""
    
    enum CodingKeys: String, CodingKey {
//        case serverUrl
        case db
        case uid
        case name
        case username
//        case sessionId
    }
    
//    init(serverUrl: String, db: String, uid: Int, username: String, name: String) {
    init() {
        self.db = ""
        self.uid = 0
        self.username = ""
        self.name = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        db = try values.decode(String.self, forKey: .db)
        uid = try values.decode(Int.self, forKey: .uid)
        username = try values.decode(String.self, forKey: .username)
        name = try values.decode(String.self, forKey: .name)
    }
}

struct UserResult: Decodable, Equatable {
    let result: User?
    let error: ServerError?
}
