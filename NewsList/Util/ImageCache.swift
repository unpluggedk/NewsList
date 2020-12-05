//
//  ImageCache.swift
//  NewsList
//
//  Created by Jason Kim on 12/4/20.
//

import UIKit

class ImageCache {
    var cache = NSCache<NSURL, UIImage>()
    
    func loadImage(url: URL) -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        return nil
    }
    
    func setImage(_ image: UIImage, forURL url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
