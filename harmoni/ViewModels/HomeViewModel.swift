//
//  HomeViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

@Observable @MainActor
final class HomeViewModel {
    var user: User?
//    var recentChapterSummary: ChapterSummary?
    
    func fetchUser(email: String) async throws -> User {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.userInfo,
            input: UserInfoInput(email: email),
            type: .query,
            withBearer: true
        ) as UserInfoResponse
        
        guard let user = gqlData.userInfo else {
            throw GraphQLError.unavailableData(queryName: "userInfo")
        }
        
        return user
    }
}
