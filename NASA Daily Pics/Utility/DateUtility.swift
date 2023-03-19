//
//  DateUtility.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation

struct DateUtility {
    
    static func lastSavedToday(dateString: String) -> Bool {
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let todayString = dateFormatter.string(from: today)
        return dateString == todayString
    }
}
