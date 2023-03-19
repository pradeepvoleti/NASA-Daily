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
    static var environment: String = "https://api.nasa.gov"
    
    static func execute(request: NetworkRequest) async throws -> Data {
        
        let request = try createRequest(request: request)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
    
    private static func createRequest(request: NetworkRequest) throws -> URLRequest {
        
        let urlString = environment + request.path
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        return urlRequest
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
