//
//  GraphQLManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import Foundation

final class GraphQLManager {
    func queryWithoutInputsHTTPBody(queryName: String) throws -> Data {
        let query = """
        {
            "query": "query { \(queryName) }"
        }
        """
        guard let httpBody = query.data(using: .utf8) else {
            throw DataSerializationError.textToDataEncoding
        }
        
        return httpBody
    }
}
