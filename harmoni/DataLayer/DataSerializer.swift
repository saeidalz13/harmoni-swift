//
//  DataSerializer.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//
import Foundation

enum DataSerializer {
    static func textToData(text: String) throws -> Data {
        guard let data = text.data(using: .utf8) else {
            throw DataSerializationError.textToDataEncoding
        }
        
        return data
    }
    
    static func encodeJSON() {
        
    }
    
    static func decodeJSON<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
            
        } catch {
            throw DataSerializationError.jsonDecoding(data: data, error: error)
        }
    }
}
