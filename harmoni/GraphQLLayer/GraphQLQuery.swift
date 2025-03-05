//
//  GraphQLQuery.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

enum GraphQLQuery: GraphQLDefinition {
    case healthCheck
    case userInfo
    case partnerInfo
    case chapters
    case mostRecentChapterMoments
    
    var requiresInput: Bool {
        switch self {
        case .healthCheck:
            return false
        default:
            return true
        }
    }
    
    // For now no input is nullable
    var nullable: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var responseFields: String? {
        switch self {
        case .mostRecentChapterMoments:
            return [.chapter, .moment].joinedResponseField()
        case .userInfo:
            return [.user(.user), .user(.partner), .bond].joinedResponseField()
        case .partnerInfo:
            return GraphQLResponseField.user(.partner).val
        default:
            return nil
        }
    }
    
    var operationType: OperationType {
        return .query
    }
    
    var query: String {
        return definitionString
    }
}

extension GraphQLQuery: CustomInputTypable {
    var customInputType: String {
        switch self {
//        case .unknown:
//            return "\(capitalizeFirstLetter(name))Input"
        default:
            return "String"
        }
    }
}


//enum GraphQLQuery {
//    case healthCheck
//    case userInfo
//    case partnerInfo
//    case chapters
//    case mostRecentChapterMoments
//    case unknown
//    
//    var name: String {
//        return String(describing: self)
//    }
//    
//    var nullable: Bool {
//        switch self {
//        default:
//            return false
//        }
//    }
//    
//    /// This excludes the parantheses
//    var operationInputClause: String? {
//        if !requiresInput { return nil }
//        
//        var res = "$\(name)Input: "
//        
//        switch self {
//        case .unknown:
//            res += "\(capitalizeFirstLetter(name))Input"
//            
//        default:
//            res += "String"
//        }
//        
//        if nullable {
//            return res
//        }
//        return "\(res)!"
//    }
//
//    var requiresInput: Bool {
//        switch self {
//        case .healthCheck:
//            return false
//        default:
//            return true
//        }
//    }
//    
//    var responseFields: String? {
//        switch self {
//        case .mostRecentChapterMoments:
//            return [.chapter, .moment].joinedResponseField()
//        case .userInfo:
//            return [.user(.user), .user(.partner), .bond].joinedResponseField()
//        default:
//            return nil
//        }
//    }
//    
//    var query: String {
//        let inputSection = requiresInput ? "(input: $\(name)Input)" : ""
//        
//        if let responseFields {
//            return "\(name)\(inputSection) { \(responseFields) }"
//        } else {
//            return "\(name)\(inputSection)"
//        }
//    }
//}
