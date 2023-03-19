//
//  DataExtensions.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

extension Data {
    func decode<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}
