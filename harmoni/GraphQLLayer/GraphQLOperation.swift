//
//  GraphQLOperation.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

struct GraphQLOperation {
    let name: String
    let definitions: [GraphQLDefinition]

    init(_ name: String, definitions: [GraphQLDefinition]) {
        self.name = name
        self.definitions = definitions
    }
    
    var string: String {
        // Collect all input clauses
        let inputClauses = definitions.compactMap { $0.operationInputClause }
        let inputClausesString = inputClauses.isEmpty ? "" : "(\(inputClauses.joined(separator: ", ")))"
        
        // Collect all definition strings
        let definitionStrings = definitions.map { $0.definitionString }
        let definitionsString = definitionStrings.joined(separator: " ")
        
        return "\(definitions.first!.operationType.rawValue) \(name)\(inputClausesString) { \(definitionsString) }"
    }
}
