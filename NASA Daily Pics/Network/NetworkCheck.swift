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

    static func isInternetAvailable() async throws -> Bool {
        
        var isAvailable = false
        
        monitor.pathUpdateHandler = { path in
            isAvailable = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        try await Task.sleep(nanoseconds: 100_000_000)
            
        monitor.cancel()
        
        return isAvailable
    }
}




