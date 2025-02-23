//
//  SecurityModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-16.
//

struct AppTokens {
    let accessToken: String
    let refreshToken: String
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
