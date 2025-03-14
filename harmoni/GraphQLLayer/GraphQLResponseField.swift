//
//  GraphQLReturnFields.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

enum UserType: String {
    case user
    case partner
}


enum GraphQLResponseField {
    case user(UserType)
    case scalar(String)
    case bond
    case chapter(String?)
    case moment(String?)
    
    var queryFragment: String {
        switch self {
        case .user(let userType):
            return "\(userType.rawValue) { id email firstName lastName birthDate }"
            
        case .scalar(let fieldName):
            return fieldName

        case .bond:
            return "bond { id bondTitle createdAt }"
            
        case .chapter(let fieldName):
            if let fieldName = fieldName, !fieldName.isEmpty {
                return "\(fieldName) { id title createdAt endsAt endedAt }"
            } else {
                return "id title createdAt endsAt endedAt"
            }
            
        case .moment(let fieldName):
            if let fieldName = fieldName, !fieldName.isEmpty {
                return "\(fieldName) { id type tag rating description createdAt }"
            } else {
                return "id type tag rating description createdAt"
            }
        }
    }
}


extension Array where Element == GraphQLResponseField {
    func joinedResponseField(separator: String = " ") -> String {
        map(\.queryFragment).joined(separator: separator)
    }
}
