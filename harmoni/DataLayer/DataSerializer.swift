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
    
    static func dataToText(data: Data) throws -> String {
        guard let text = String(data: data, encoding: .utf8) else {
            throw DataSerializationError.dataToTextDecoding
        }
        
        return text
    }
    
    static func encodeJSON<T: Encodable>(value: T) throws -> Data {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            
            return try encoder.encode(value)
            
        } catch {
            throw DataSerializationError.jsonEncoding(error: error)
        }
        
    }
    
    static func decodeJSON<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
            
        } catch {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(jsonString)")
            }
            throw DataSerializationError.jsonDecoding(data: data, error: error)
        }
    }
}
