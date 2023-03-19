//
//  PlanetaryService.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

protocol PlanetaryService {
    static func getPictureOfTheDay() async throws -> DailyPicture
}

struct PlanetaryDefaultService: PlanetaryService {
    
    enum Paths: String {
        case apod = "/planetary/apod?api_key="
    }
    
    static var networkCommunication: NetworkCommunicationType.Type = NetworkCommunication.self

    static func getPictureOfTheDay() async throws -> DailyPicture {
        
        let request = NetworkRequest(path: Paths.apod.rawValue + NetworkCommunication.apiKey)
        let data = try await networkCommunication.execute(request: request)
        let model = try data.decode() as DailyPicture
        return model
    }
}
