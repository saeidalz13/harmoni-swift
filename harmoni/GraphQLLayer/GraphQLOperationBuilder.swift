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
    case createChapter
    
    case userInfo
    case partnerInfo
    case homeSummary
    
    var operationName: String {
        return capitalizeFirstLetter(String(describing: self))
    }
    
    func build() -> GraphQLOperation {
        switch self {
            
        /// Mutation
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
        case .createChapter:
            return .init(operationName, definitions: [GraphQLMutation.createChapter])
            
        /// Queries
        case .userInfo:
            return .init(operationName, definitions: [GraphQLQuery.userInfo])
        case .partnerInfo:
            return .init(operationName, definitions: [GraphQLQuery.partnerInfo])
        case .homeSummary:
            return .init(operationName, definitions: [GraphQLQuery.mostRecentChapterMoments])
        }
    }
}
