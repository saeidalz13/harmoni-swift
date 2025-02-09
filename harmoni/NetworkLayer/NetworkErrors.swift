//
//  NetworkEnums.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case timeout
    case serverError(code: Int)
    case invalidWebSocketMessageType(desc: String)
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .noInternetConnection:
            return "No internet connection."
        case .timeout:
            return "The request timed out."
        case .serverError(let code):
            return "Server error occurred with status code \(code)."
        case .invalidWebSocketMessageType(let desc):
            return "invalid type of data in ws conn: \(desc)"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
    
    static func fromNSError(_ error: NSError) -> NetworkError {
        switch error.code {
        case NSURLErrorNotConnectedToInternet:
            return .noInternetConnection
        case NSURLErrorTimedOut:
            return .timeout
        case NSURLErrorBadURL:
            return .invalidURL
        case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            return .serverError(code: error.code)
        default:
            return .unknown(error)
        }
    }
}
