//
//  GraphQLOperationManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

enum GraphQLOperationBuilder {
    case renewAccessToken
    case authenticateBackend
    case createBond
    case joinBond
    case logOut
    case updateUser
    
    case userInfo
    case partnerInfo
    
    var operationName: String {
        return capitalizeFirstLetter(String(describing: self))
    }
    
    func build() -> GraphQLOperation {
        switch self {
        case .renewAccessToken:
            return .init(operationName, definitions: [GraphQLMutation.renewAccessToken])
        case .authenticateBackend:
            return .init(operationName, definitions: [GraphQLMutation.authenticateIdToken])
        case .logOut:
            return .init(operationName, definitions: [GraphQLMutation.logOut])
        case .updateUser:
            return .init(operationName, definitions: [GraphQLMutation.updateUser])
        case .createBond:
            return .init(operationName, definitions: [GraphQLMutation.createBond])
        case .joinBond:
            return .init(operationName, definitions: [GraphQLMutation.joinBond])
        case .userInfo:
            return .init(operationName, definitions: [GraphQLQuery.userInfo])
        case .partnerInfo:
            return .init(operationName, definitions: [GraphQLQuery.partnerInfo])
        }
    }
}
