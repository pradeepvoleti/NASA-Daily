//
//  DailyPictureState.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

struct DailyPictureState {
    
    var title: String = ""
    var explination: String = ""
    var imageUrl: String = ""
    var imageData: Data?
    var hasNetwork: Bool = true
}
