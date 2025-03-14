//
//  RelationshipModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-07.
//
import Foundation

struct Chapter: Codable {
    let id: String
    let title: String
    let createdAt: String
    let endsAt: String
    let endedAt: String?
}

struct Moment: Codable {
    let id: String
    let type: String
    let tag: String
    let rating: Int
    let description: String
    let createdAt: String
}

struct MostRecentChapterMomentsPayload: Codable {
    let recentChapter: Chapter!
    let recentMoments: [Moment]!
}


// create chapter
struct CreateChapterInput: Codable {
    let bondId: String
    let chapterTitle: String
    let chapterDays: Int
}

struct CreateChapterVariables: Codable {
    let createChapterInput: CreateChapterInput
}

struct CreateChapterResponse: Codable {
    let createChapter: Chapter
}
