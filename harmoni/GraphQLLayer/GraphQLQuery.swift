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
    // Mutations
    case updateUser
    case authenticateIdToken
    case logOut
    case renewAccessToken
    case createBond
    case updateBond
    case joinBond
    
    // Queries
    case userInfo
    case partnerInfo
    
    var str: String {
        return String(describing: self)
    }
    
    private var capitalizedStr: String {
        let description = String(describing: self)
        return description.prefix(1).capitalized + description.dropFirst()
    }
    
    func generate(type: GraphQLRequestType, withInput: Bool = true) -> String {
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
                bondCreatedAt
                partnerId
                partnerEmail
                partnerFirstName
                partnerLastName
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
            
        case .joinBond:
            returnField = """
            bondId
            bondTitle
            bondCreatedAt
            partnerId
            partnerEmail
            partnerFirstName
            partnerLastName
            """
        
        case .userInfo:
            returnField = """
            id 
            email 
            firstName 
            lastName 
            bondTitle 
            bondId
            bondCreatedAt
            partnerId
            partnerEmail
            partnerFirstName
            partnerLastName
            """
            
        case .partnerInfo:
            returnField = """
            partnerId
            partnerEmail
            partnerFirstName
            partnerLastName
            """
        }
        
        if withInput {
            return generateQueryWithInput(type: type, returnFields: returnField)
        }
        
        return generateQuery(type: type, returnFields: returnField)
    }
    
    private func generateQueryWithInput(type: GraphQLRequestType, returnFields: String) -> String {
        return """
        \(type.rawValue) \(capitalizedStr)($input: \(capitalizedStr)Input!) { 
            \(str)(input: $input) { 
                \(returnFields)
            } 
        }
        """
    }
    
    private func generateQuery(type: GraphQLRequestType, returnFields: String) -> String {
        return """
       \(type.rawValue) {
            \(str) { 
                \(returnFields)
            } 
       }
       """
    }
    
    private func getFieldNames<T>(from object: T) -> String {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { $0.label }.joined(separator: "\n")
    }
    
    
}

