//
//  SecurityManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-16.
//

import Security
import Foundation

struct AppTokens {
    let accessToken: String
    let refreshToken: String
}

enum SecurityManager {
    static func saveToKeychain(token: String, key: String) throws {
        let data = try DataSerializer.textToData(text: token)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        SecItemAdd(query as CFDictionary, nil)
    }

    static func retrieveFromKeychain(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            return String(data: dataTypeRef as! Data, encoding: .utf8)
        }
        return nil
    }
    
    static func removeFromKeychain(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    static func removeTokensFromKeychain() {
        for key in [KeychainTokenKey.accessToken.rawValue, KeychainTokenKey.refreshToken.rawValue] {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            SecItemDelete(query as CFDictionary)
        }
    }

}

