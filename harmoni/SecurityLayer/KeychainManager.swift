//
//  SecurityManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-16.
//

import Security
import Foundation


final class SecurityManager: Sendable {
    static let shared = SecurityManager()
    private init() {}
    
    private func saveToKeychain(token: String, key: String) throws {
        let data = try DataSerializer.textToData(text: token)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func retrieveFromKeychain(key: String) -> String? {
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
    
    func removeTokensFromKeychain() {
        for key in KeychainTokenKey.getKeys() {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            SecItemDelete(query as CFDictionary)
        }
    }
    
    func saveTokensToKeychain(accessToken: String, refreshToken: String) throws {
        let keys = KeychainTokenKey.getKeys()
        
        for (key, value) in zip(keys, [accessToken, refreshToken]) {
            try saveToKeychain(token: value, key: key)
        }
    }
    
}

