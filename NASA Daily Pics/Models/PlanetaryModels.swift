//
//  PlanetaryModels.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

struct DailyPicture: Decodable {
    let title: String
    let explanation: String
    let url: String
    let date: String
}
