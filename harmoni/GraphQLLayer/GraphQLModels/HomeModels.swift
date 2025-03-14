//
//  HomeModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-07.
//


struct HomeSummaryInput: Codable {
    let mostRecentChapterMomentsInput: String
}

struct HomeSummaryResponse: Codable {
    let mostRecentChapterMoments: MostRecentChapterMomentsPayload?
}
