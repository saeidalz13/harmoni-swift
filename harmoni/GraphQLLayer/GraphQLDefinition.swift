//
//  GraphQLDefinition.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

protocol GraphQLDefinition {
    var name: String { get }
    var nullable: Bool { get }
    var requiresInput: Bool { get }
    var responseFields: String? { get }
    var operationInputClause: String? { get }
    var definitionString: String { get }
    var operationType: OperationType { get }
}

protocol CustomInputTypable {
    var customInputType: String { get }
}


enum OperationType: String {
    case query
    case mutation
    case subscription
}


extension GraphQLDefinition {
    var name: String {
        return String(describing: self)
    }
    
    var nullable: Bool {
        return false
    }
    
    var operationInputClause: String? {
        if !requiresInput { return nil }
        
        var res = "$\(name)Input: "
        
        if let customInputType = (self as? CustomInputTypable)?.customInputType {
            res += customInputType
        } else {
            res += "\(capitalizeFirstLetter(name))Input"
        }
        
        return nullable ? res : "\(res)!"
    }
    
    var definitionString: String {
        let inputSection = requiresInput ? "(input: $\(name)Input)" : ""
        
        if let responseFields = responseFields {
            return "\(name)\(inputSection) { \(responseFields) }"
        } else {
            return "\(name)\(inputSection)"
        }
    }
}

