//
//  FileManager.swift
//  NASA Daily Pics
//
//  Created by APPLE on 19/03/23.
//

import Foundation
import UIKit

struct FileHelper {
    
    static var directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    static let cacheImage = "SavedPic"
    
    static func save(image data: Data?) {
        
        guard let directoryURL, let data else { return }
        
        let fileURL = directoryURL.appendingPathComponent(cacheImage)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    static func getImage() -> Data? {
        
        guard let directoryURL else { return nil }
        
        let fileURL = directoryURL.appendingPathComponent(cacheImage)
        
        guard FileManager.default.fileExists(atPath: fileURL.path),
              let imageData = FileManager.default.contents(atPath: fileURL.path)
        else { return nil }
        
        return imageData
    }
}
