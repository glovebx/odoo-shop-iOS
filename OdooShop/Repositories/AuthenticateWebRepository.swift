//
//  AuthenticateWebRepository.swift
//  OdooShop
//
//  Created by glovebx on 2022/7/30.
//

import Combine
import Foundation
import SwiftUI

protocol AuthenticateWebRepositoryProtocol: WebRepositoryProtocol {
    func loadServerVersion(login: Login) -> AnyPublisher<ServerVersionResult, Error>
    func listDatabase(login: Login) -> AnyPublisher<DbResult, Error>
    func authenticate(login: Login) -> AnyPublisher<UserResult, Error>
}

struct AuthenticateWebRepository: AuthenticateWebRepositoryProtocol {
    var session: URLSession
    var bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession) {
        self.session = session
    }
    
    func loadServerVersion(login: Login) -> AnyPublisher<ServerVersionResult, Error> {
        return call(endpoint: API.versionInfo(login))
    }
    
    func listDatabase(login: Login) -> AnyPublisher<DbResult, Error> {
        return call(endpoint: API.database(login))
    }
    
    // Mark - login
    func authenticate(login: Login) -> AnyPublisher<UserResult, Error> {
        return call(endpoint: API.authenticate(login))
    }
}

extension AuthenticateWebRepository {
    enum API {
        case versionInfo(Login)
        case database(Login)
        case authenticate(Login)
    }
}

extension AuthenticateWebRepository.API: APICall {
    var baseURL: String {
        switch self {
        case let .versionInfo(login), let .database(login), let .authenticate(login):
            return login.serverUrl
        }
    }
    
    var path: String {
        switch self {
        case .versionInfo(_):
            return "/web/webclient/version_info"
        case .database(_):
            return "/web/database/list"
        case .authenticate(_):
            return "/web/session/authenticate"
        }
    }
    
    var method: String {
        return "POST"
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=UTF-8",
                "Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        switch self {
        case .versionInfo, .database:
            let json: [String: Any] = [:]
            return try? JSONSerialization.data(withJSONObject: json)
        case let .authenticate(login):
            let json: [String: Any] = ["id": arc4random_uniform(1000000000),
                                       "jsonrpc": "2.0",
                                       "method": "call",
                                       "params": ["db": login.database,
                                                  "login": login.username,
                                                  "password": login.password]]
            let data = try? JSONSerialization.data(withJSONObject: json)    // , options: [.sortedKeys, .withoutEscapingSlashes]
            if let data = data {
                let str = String(data: data, encoding: String.Encoding.utf8)
                dump(str)
            }
            return data
        }
    }
    
    
}
