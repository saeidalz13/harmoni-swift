//
//  AppErrors.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation

enum DataSerializationError: Error, LocalizedError {
    case textToDataEncoding
    case dataToTextDecoding
    case jsonEncoding
    case jsonDecoding(data: Data)
    case unknown(Error)

    var localizedDescription: String? {
        switch self {
        case .textToDataEncoding:
            return "Failed to convert text to data."
        case .dataToTextDecoding:
            return "Failed to convert data to text."
        case .jsonEncoding:
            return "Failed to encode object to JSON."
        case .jsonDecoding(let data):
            return "Failed to decode JSON to object: \(data)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
