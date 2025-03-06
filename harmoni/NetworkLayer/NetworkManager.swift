//
//  NetworkManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

import Foundation

final class NetworkManager: Sendable {
    static let shared = NetworkManager()
    private init() {}
    
    func makeHTTPPostRequest(httpBody: Data? = nil, withBearer: Bool) async throws -> Data {
        var accessToken: String?
        if withBearer {
            if let token = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.accessToken) {
                accessToken = token
            } else {
                throw SecurityError.unavailableToken
            }
        }
            
        let request = createPostRequest(httpBody: httpBody, bearerToken: accessToken)
        
//        print(try DataSerializer.dataToText(data: request.httpBody!))
            
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
            
        case 403:
            print("Forbidden error (403): \(httpResponse)")
            throw NetworkError.forbidden
        
        case 401:
            throw NetworkError.expiredAccessToken
            
        default:
            print("Server error: \(httpResponse)")
            throw NetworkError.serverError(code: httpResponse.statusCode)
        }
    
        return data
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
    
    
//    func getWebSocketMessage(ws: URLSessionWebSocketTask) async throws -> Data {
//        do {
//            ws.resume()
//            let message = try await ws.receive()
//    
//            switch message {
//            case .string(let text):
//                return try DataSerializer.textToData(text: text)
//                
//            case .data(let data):
//                return data
//                
//            default:
//                throw NetworkError.invalidWebSocketMessageType(desc: "must be string in oAuth2 google")
//            }
//            
//        } catch {
//            throw error
//        }
//    }
//    
//    func newWebSocketTask() -> URLSessionWebSocketTask {
//        let session = URLSession(configuration: .default)
//        let ws = session.webSocketTask(with: ServerEndpoint.googleWebSocket.url)
//        return ws
//    }
//    
//    func closeWebSocketConn(ws: URLSessionWebSocketTask) {
//        ws.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
//    }

}



//class AuthorizationInterceptor: ApolloInterceptor {
//    public var id: String = UUID().uuidString
//
//    func interceptAsync<Operation>(
//        chain: any Apollo.RequestChain,
//        request: Apollo.HTTPRequest<Operation>,
//        response: Apollo.HTTPResponse<Operation>?,
//        completion: @escaping (Result<Apollo.GraphQLResult<Operation.Data>, any Error>) -> Void
//    ) where Operation : ApolloAPI.GraphQLOperation {
//        print(Operation.operationName)
//
//        guard let accessToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainTokenKey.accessToken.rawValue) else {
//            completion(.failure(SecurityError.unavailableToken))
//            return
//        }
//
//        request.addHeader(name: "Authorization", value: "Bearer \(accessToken)")
//
//        chain.proceedAsync(
//            request: request,
//            response: response,
//            interceptor: self,
//            completion: completion
//        )
//    }
//}
//
//class NetworkInterceptorProvider: DefaultInterceptorProvider {
//    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
//        var interceptors = super.interceptors(for: operation)
//        interceptors.insert(AuthorizationInterceptor(), at: 0)
//        return interceptors
//    }
//}

//    static let shared = NetworkManager()
//
//    private(set) lazy var apollo: ApolloClient = {
//        let client = URLSessionClient()
//        let cache = InMemoryNormalizedCache()
//        let store = ApolloStore(cache: cache)
//        let provider = NetworkInterceptorProvider(client: client, store: store)
//        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: ServerEndpoint.graphQL.url)
//
//        return ApolloClient(networkTransport: transport, store: store)
//    }()
//
