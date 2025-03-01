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
}
