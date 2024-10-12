//
//  UIImageExtension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 12/10/24.
//

import Foundation
import UIKit

struct Helper {
    static func downloadImage(from urlString: String) async -> UIImage? {
        let cache = NSCache<NSString, UIImage>()
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }

        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { return nil }
            
            cache.setObject(image, forKey: cacheKey)
            
            return image
        } catch {
            return nil
        }

    }
}
