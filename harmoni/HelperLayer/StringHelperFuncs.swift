//
//  StringHelperFuncs.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

func capitalizeFirstLetter(_ str: String) -> String {
    return str.prefix(1).capitalized + str.dropFirst()
}
