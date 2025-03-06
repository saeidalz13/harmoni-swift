//
//  AppEnums.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

enum ButtonActionResult {
    case fulfilled(_ msg: String)
    case notFulfilled(_ msg: String)
    case serverError
    
    var msg: String {
        switch self {
        case .serverError:
            return "Guess this is an oopsie for us 🥸"
        case .fulfilled(let msg), .notFulfilled(let msg):
            return msg
        }
    }
    
    var title: String {
        switch self {
        case .notFulfilled:
            return "Not Fulfilled"
        case .serverError:
            return "Server Error"
        case .fulfilled:
            return "Success"
        }
    }
}

enum TabSelection: Int8 {
    case auth
    case home
    case relationship
    case finance
    case upkeep
    case settings
}

enum BackgroundViewSelection {
    case tabSelection(TabSelection)
    case popover
}
