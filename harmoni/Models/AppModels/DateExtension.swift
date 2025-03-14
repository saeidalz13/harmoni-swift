//
//  DateExtension.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//
import Foundation

extension DateFormatter {
    static let HarmoniFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // ISO8601 format example
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    static let BirthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'12:00:00'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
}


//extension Date {
//    func toLocalTime() -> Date {
//        let timezone = TimeZone.current
//        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
//        return Date(timeInterval: seconds, since: self)
//    }
//    
//    func formatForLocalDisplay() -> String {
//        let localFormatter = DateFormatter()
//        localFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        localFormatter.timeZone = TimeZone.current
//        return localFormatter.string(from: self)
//    }
//}
