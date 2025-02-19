//
//  NetworkManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation

final class NetworkManager: Sendable {

    func makeHTTPPostRequest(httpBody: Data? = nil, withBearer: Bool) async throws -> Data {
        do {
            var accessToken: String?
            if withBearer {
                if let token = SecurityManager.retrieveFromKeychain(key: KeychainTokenKey.accessToken.rawValue) {
                    accessToken = token
                } else {
                    throw SecurityError.unavailableToken
                }
            }
            
            let request = createPostRequest(httpBody: httpBody, bearerToken: accessToken)
                
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break
                default:
                    print(httpResponse)
                    throw NetworkError.serverError(code: httpResponse.statusCode)
                }
            }
        
            return data
            
        } catch let error as NSError {
            throw NetworkError.fromNSError(error)
            
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
    private func createPostRequest(httpBody: Data? = nil, bearerToken: String? = nil) -> URLRequest {
        var request = URLRequest(url: ServerEndpoint.graphQL.url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bearerToken {
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = httpBody
        return request
    }
    
    
    func getWebSocketMessage(ws: URLSessionWebSocketTask) async throws -> Data {
        do {
            ws.resume()
            let message = try await ws.receive()
    
            switch message {
            case .string(let text):
                return try DataSerializer.textToData(text: text)
                
            case .data(let data):
                return data
                
            default:
                throw NetworkError.invalidWebSocketMessageType(desc: "must be string in oAuth2 google")
            }
            
        } catch {
            throw error
        }
    }
    
    func newWebSocketTask() -> URLSessionWebSocketTask {
        let session = URLSession(configuration: .default)
        let ws = session.webSocketTask(with: ServerEndpoint.googleWebSocket.url)
        return ws
    }
    
    func closeWebSocketConn(ws: URLSessionWebSocketTask) {
        ws.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
    }

}
