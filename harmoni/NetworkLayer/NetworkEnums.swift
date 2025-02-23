//
//  NetworkEnums.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case GET
    case OPTION
    case DELETE
}

enum ServerEndpoint {
    case googleWebSocket
    case graphQL

    var url: URL {
        switch self {
        case .googleWebSocket:
            return URL(string:  "ws://localhost:1919/ws-oauth2")!
        case .graphQL:
            return URL(string: "http://localhost:1919/graphql")!
        }
    }
}
