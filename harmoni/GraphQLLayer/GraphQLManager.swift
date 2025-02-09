//
//  GraphQLManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import Foundation

@Observable class GraphQLManager {
    private var backendUrl = URL(string: "http://localhost:1919/query")!
    
    func createGQLRequest() -> URLRequest {
        var request = URLRequest(url: backendUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func queryWithoutInputs<T: Decodable>(queryName: String) async throws -> GraphQLData<T> {
        var request = createGQLRequest()
        
        let query = """
        {
            "query": "query { \(queryName) }"
        }
        """
        guard let jsonData = query.data(using: .utf8) else {
            throw URLError(.cannotParseResponse)
        }
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(GraphQLData<T>.self, from: data)
    }
}
