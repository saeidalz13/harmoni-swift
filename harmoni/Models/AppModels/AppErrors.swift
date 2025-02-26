//
//  AppErrors.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation


enum GeneralError: Error, LocalizedError {
    case optionalFieldUnavailable(fieldName: String)
    
    var localizedDescription: String {
        switch self {
        case .optionalFieldUnavailable(let fieldName):
            return "\(fieldName) is unavailable in object"
        }
    }
}


enum DataSerializationError: Error, LocalizedError {
    case textToDataEncoding
    case dataToTextDecoding
    case jsonEncoding(error: Error)
    case jsonDecoding(data: Data, error: Error)
    case unknown(Error)

    var localizedDescription: String? {
        switch self {
        case .textToDataEncoding:
            return "Failed to convert text to data."
        case .dataToTextDecoding:
            return "Failed to convert data to text."
        case .jsonEncoding(let error):
            return "Failed to encode object to JSON: \(error.localizedDescription)"
        case .jsonDecoding(let data, let error):
            return "Failed to decode JSON to object: \(data) \(error.localizedDescription)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

enum ModelContextError: Error, LocalizedError {
    case nilContext
    
    var localizedDescription: String? {
        return "Model context is nil."
    }
}
