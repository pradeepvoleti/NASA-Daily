//
//  NetworkCheck.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation
import Network

struct NetworkCheck {
    
    static let monitor = NWPathMonitor()

    static func isInternetAvailable() async -> Bool {
        
        var isAvailable = false
        
        monitor.pathUpdateHandler = { path in
            isAvailable = path.status == .satisfied
            monitor.cancel()
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        await Task.sleep(100_000_000)
            
            monitor.cancel()
        
        return isAvailable
    }
}




