//
//  GraphQLMutationQueryFields.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-10.
//
enum GraphQLRequestType: String {
    case mutation = "mutation"
    case query = "query"
}

enum GraphQLQuery {
    case updateUser
    case authenticateIdToken
    case logOut
    case renewAccessToken
    
    var name: String {
        return String(describing: self)
    }

    func generate(type: GraphQLRequestType) -> String {
        var inputs: (String, String)
        var returnField: String
        
        switch self {
        case .authenticateIdToken:
            inputs = ("authenticateIdToken", "AuthenticateIdToken")
            returnField = """
            user {
                id 
                email 
                firstName 
                lastName 
                familyTitle 
                familyId
                partnerId
            }
            accessToken
            refreshToken
            """
            
        case .updateUser:
            inputs = ("updateUser", "UpdateUser")
            returnField = "id"
            
        case .logOut:
            inputs = ("logOut", "LogOut")
            returnField = "id"
            
        case .renewAccessToken:
            inputs = ("renewAccessToken", "RenewAccessToken")
            returnField = """
            id
            accessToken
            """
        }
        
        return queryTemplate(type: type, inputs: inputs, returnFields: returnField)
    }
    
    private func queryTemplate(type: GraphQLRequestType, inputs: (String, String), returnFields: String) -> String {
        return """
        \(type.rawValue) \(inputs.1)($input: \(inputs.1)Input!) { 
            \(inputs.0)(input: $input) { 
                \(returnFields)
            } 
        }
        """
    }
}
