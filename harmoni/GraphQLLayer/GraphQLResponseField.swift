//
//  GraphQLReturnFields.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

enum GraphQLReturnField {
    case user(_ userOrPartner: String)
    case id
    case bondId
    case bond
    
    var val: String {
        switch self {
        case .user(let userOrPartner):
            return """
            \(userOrPartner) {
                id 
                email 
                firstName 
                lastName
                birthDate
            }
            """
        case .id:
            return "id"
        case .bondId:
            return "bondId"
        case .bond:
            return """
            bond {
                id
                bondTitle
                createdAt
            }
            """
        }
    }
}
