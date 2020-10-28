//
//  ImageCache.swift
//  SwiftEasyExtension
//
//  Created by Arvind on 24/04/2020.
//  Copyright © 2020 Arvind. All rights reserved.
//

import UIKit

final class ImageCache {
    
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
    }
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

//MARK: - ImageCacheType

extension ImageCache: ImageCacheType {
    
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
            return decodedImage
        }
        
        return nil
    }
    
    func insertImage(_ img: UIImage?, for url: URL) {
        guard let img = img else { return removeImage(for: url) }
        let decodedImage = img.decodedImage()
        
        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decodedImage, forKey: url as AnyObject)
        decodedImageCache.setObject(img as AnyObject, forKey: url as AnyObject)
    }
    
    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImage() {
        
    }
    
    subscript(url: URL) -> UIImage? {
        get {
            return image(for: url)
        }
        set {
            return insertImage(newValue, for: url)
        }
    }
}
