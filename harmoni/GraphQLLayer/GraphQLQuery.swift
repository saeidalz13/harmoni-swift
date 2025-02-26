//
//  GraphQLMutationQueryFields.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-10.
//
import Foundation

enum GraphQLRequestType: String {
    case mutation = "mutation"
    case query = "query"
}

enum GraphQLQuery {
    case updateUser
    case authenticateIdToken
    case logOut
    case renewAccessToken
    case createBond
    case updateBond
    
    var str: String {
        return String(describing: self)
    }

    private var capitalizedStr: String {
        let description = String(describing: self)
        return description.prefix(1).capitalized + description.dropFirst()
    }
    
    func generate(type: GraphQLRequestType) -> String {
        var returnField: String
        
        switch self {
        case .authenticateIdToken:
            returnField = """
            user {
                id 
                email 
                firstName 
                lastName 
                bondTitle 
                bondId
                partnerId
            }
            accessToken
            refreshToken
            """
            
        case .updateUser:
            returnField = "id"
            
        case .logOut:
            returnField = "id"
            
        case .renewAccessToken:
            returnField = """
            id
            accessToken
            """
        case .createBond:
            returnField = """
            id
            bondTitle
            createdAt
            """
        case .updateBond:
            returnField = """
            id
            bondTitle
            createdAt
            """
        }
        
        return queryTemplate(type: type, returnFields: returnField)
    }
    
    func getFieldNames<T>(from object: T) -> String {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { $0.label }.joined(separator: "\n")
    }
    
    private func queryTemplate(type: GraphQLRequestType, returnFields: String) -> String {
        return """
        \(type.rawValue) \(capitalizedStr)($input: \(capitalizedStr)Input!) { 
            \(str)(input: $input) { 
                \(returnFields)
            } 
        }
        """
    }
}

