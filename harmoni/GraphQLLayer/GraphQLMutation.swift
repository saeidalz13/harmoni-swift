//
//  GraphQLMutation.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

enum GraphQLMutation: GraphQLDefinition {
    case updateUser
    case authenticateIdToken
    case logOut
    case renewAccessToken
    case createBond
    case updateBond
    case joinBond
    
    case createChapter
    
    var requiresInput: Bool {
        switch self {
        case .logOut:
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
        case .authenticateIdToken:
            return "accessToken refreshToken"
        case .renewAccessToken:
            return "id accessToken"
        case .updateBond:
            return GraphQLResponseField.scalar("bondId").queryFragment
        case .createChapter:
            return GraphQLResponseField.chapter(nil).queryFragment
        default:
            return nil
        }
    }
    
    var operationType: OperationType {
        return .mutation
    }
    
    var mutation: String {
        return definitionString
    }
}

extension GraphQLMutation: CustomInputTypable {
    var customInputType: String {
        switch self {
//        case .unknown:
//            return "String"
        default:
            return "\(capitalizeFirstLetter(name))Input"
        }
    }
}

//enum GraphQLMutation {
//    case updateUser
//    case authenticateIdToken
//    case logOut
//    case renewAccessToken
//    case createBond
//    case updateBond
//    case joinBond
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
//            // Might be other cases in the future
//            
//        default:
//            res += "\(capitalizeFirstLetter(name))Input"
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
//        case .logOut:
//            return false
//        default:
//            return true
//        }
//    }
//    
//    var responseFields: String? {
//        switch self {
//        case .authenticateIdToken:
//            return "accessToken refreshToken"
//        case .renewAccessToken:
//            return "id accessToken"
//        case .updateBond:
//            return GraphQLResponseField.bond.val
//        default:
//            return nil
//        }
//    }
//    
//    var mutation: String {
//        let inputSection = requiresInput ? "(input: $\(name)Input)" : ""
//        
//        if let responseFields {
//            return "\(name)\(inputSection) { \(responseFields) }"
//        } else {
//            return "\(name)\(inputSection)"
//        }
//    }
//    
//    
//}
