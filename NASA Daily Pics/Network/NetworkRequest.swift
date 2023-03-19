//
//  NetworkRequest.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

struct NetworkRequest {
    
    let path: String
    var httpMethod: HTTPMethod = .get
    var httpBody: Data? = nil
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
