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

    static func isInternetAvailable(completion: @escaping (Bool) -> Void) {

        monitor.pathUpdateHandler = { path in
            let status = path.status == .satisfied
            completion(status)
            monitor.cancel()
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}




