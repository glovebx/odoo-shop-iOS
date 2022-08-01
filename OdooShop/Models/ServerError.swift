//
//  File.swift
//  OdooShop
//
//  Created by glovebx on 2022/8/1.
//

import Foundation

struct ServerError: Decodable, Equatable {
    let message: String
    let data: ServerErrorData
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decode(String.self, forKey: .message)
        data = try values.decode(ServerErrorData.self, forKey: .data)
    }
}

struct ServerErrorData: Decodable, Equatable {
    let name: String
    let debug: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case debug
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        debug = try values.decode(String.self, forKey: .debug)
    }
}
