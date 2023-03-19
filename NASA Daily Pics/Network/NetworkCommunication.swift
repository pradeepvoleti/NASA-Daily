//
//  NetworkCommunication.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case serverError(Error)
    case emptyData
}

protocol NetworkCommunicationType {
    
    static func execute(request: NetworkRequest) async throws -> Data
}

struct NetworkCommunication: NetworkCommunicationType {
    
    static let session = URLSession.shared
    
    static func execute(request: NetworkRequest) async throws -> Data {
        
        var urlRequest = URLRequest(url: "")
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
}

struct NetworkRequest {
    
    let path: String
    var httpMethod: HTTPMethod = .get
    var httpBody: Data? = nil
}

struct NetworkResponse {
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
