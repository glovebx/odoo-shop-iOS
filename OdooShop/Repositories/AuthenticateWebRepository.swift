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
    func loadServerVersion() -> AnyPublisher<ServerVersionData, Error>
}

struct AuthenticateWebRepository: AuthenticateWebRepositoryProtocol {
    
    var session: URLSession
    var baseURL: String
    var bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadServerVersion() -> AnyPublisher<ServerVersionData, Error> {
        return call(endpoint: API.versionInfo)
    }
}

extension AuthenticateWebRepository {
    enum API {
        case versionInfo
    }
}

extension AuthenticateWebRepository.API: APICall {
    var path: String {
        return "/web/webclient/version_info"
    }
    
    var method: String {
        return "POST"
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        // dummy json data
        let json: [String: Any] = [:]
        return try? JSONSerialization.data(withJSONObject: json)
    }
    
    
}
