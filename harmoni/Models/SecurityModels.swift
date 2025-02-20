//
//  SecurityModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-16.
//

enum KeychainTokenKey: String {
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
    
    static func getKeys() -> [String] {
        return [KeychainTokenKey.accessToken.rawValue, KeychainTokenKey.refreshToken.rawValue]
    }
}

enum SecurityError: Error {
    case invalidToken
    case unavailableToken
    
    var localizedDescription: String {
        switch self {
        case .invalidToken:
            return "Invalid token"
        case .unavailableToken:
            return "Unavailable token"
        }
    }
}
