//
//  GraphQLReturnFields.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

enum UserOrPartner: String {
    case user
    case partner
}


enum GraphQLResponseField {
    case user(_ userOrPartner: UserOrPartner)
    case id
    case bondId
    case bond
    case chapter
    case moment
    
    var val: String {
        switch self {
        case .user(let userOrPartner):
            return "\(userOrPartner.rawValue) { id email firstName lastName birthDate }"
            
        case .id:
            return "id"
            
        case .bondId:
            return "bondId"
            
        case .bond:
            return "bond { id bondTitle createdAt }"
            
        case .chapter:
            return "chapter { id title createdAt endsAt endedAt }"
            
        case.moment:
            return "moment { id type tag rating description createdAt }"
        }
    }
}


extension Array where Element == GraphQLResponseField {
    func joinedResponseField(separator: String = " ") -> String {
        map(\.val).joined(separator: separator)
    }
}
