//
//  SecurityManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-16.
//

import Security
import Foundation

enum KeychainKey: String {
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
    case isHarmoniFirstTimeUser = "isHarmoniFirstTimeUser"
    
    static func getKeys() -> [KeychainKey] {
        return [KeychainKey.accessToken, KeychainKey.refreshToken]
    }
}

final class KeychainManager: Sendable {
    static let shared = KeychainManager()
    private init() {}
    
    func saveToKeychain(token: String, key: KeychainKey) throws {
        let data = try DataSerializer.textToData(text: token)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func removeTokenByKey(key: KeychainKey) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    func retrieveFromKeychain(key: KeychainKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
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
        for key in KeychainKey.getKeys() {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key.rawValue
            ]
            SecItemDelete(query as CFDictionary)
        }
    }
    
    func saveTokensToKeychain(accessToken: String, refreshToken: String) throws {
        let keys = KeychainKey.getKeys()
        
        for (key, value) in zip(keys, [accessToken, refreshToken]) {
            try saveToKeychain(token: value, key: key)
        }
    }
    
}

