//
//  WebRepository.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation
import Combine

protocol WebRepositoryProtocol {
    var session: URLSession { get }
//    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepositoryProtocol {
    // TODO: cookieHandler refactor
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success,
                     cookieHandler: @escaping (String) -> Void = {_ in }) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.urlRequest()
            return session
                .dataTaskPublisher(for: request)
                .map{
                    dump($0)
                    
                    if endpoint.path == "/web/session/authenticate" {
                        if let response = $0.1 as? HTTPURLResponse,
                           let fields = response.allHeaderFields as? [String: String] {
                            // Get cookie with key "Set-Cookie"
                            if let cookie = fields["Set-Cookie"]?.split(separator: ";")
                                .first(where: { $0.contains("session_id")})?.split(separator: "=").last {
                                cookieHandler(String(cookie))
                            }
                        }
                    }
                    return $0
                }
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Helpers

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw APIError.unexpectedResponse
                }
                guard httpCodes.contains(code) else {
                    throw APIError.httpCode(code)
                }
                return $0.0
            }
            .extractUnderlyingError()
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        
        return requestData(httpCodes: httpCodes)
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
