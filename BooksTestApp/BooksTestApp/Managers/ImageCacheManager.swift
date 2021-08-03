//
//  ImageCacheManager.swift
//  BooksTestApp
//
//  Created by Majit Uteniyazov on 04/08/21.
//

import UIKit
import Kingfisher


class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    func setupCache() {
        let downloader = ImageDownloader.default
        let cache = ImageCache.default
        
        downloader.downloadTimeout = 120
        KingfisherManager.shared.downloader = downloader
        
        cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024
        cache.memoryStorage.config.countLimit = 150
        cache.memoryStorage.config.expiration = .days(7)
        
        cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
        cache.diskStorage.config.expiration = .days(7)
        
        cache.cleanExpiredMemoryCache()
        cache.cleanExpiredDiskCache { print("Done cleanExpiredDiskCache") }
    }
    
    func cacheImages(with urls: [URL], _ completionHandler: @escaping ((_ hasError: Bool) -> ())) {
        let endIndex = urls.endIndex - 1
        urls.enumerated().forEach { index, url in
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success:
                    print("Cached with url \(url)")
                    if index == endIndex {
                        completionHandler(false)
                    }
                case .failure:
                    print("Could not cache image with url \(url)")
                    if index == endIndex {
                        completionHandler(true)
                    }
                }
            }
        }
    }
    
    func getImage(with url: URL?, _ completionHandler: @escaping ((UIImage) -> ())) {
        guard let url = url else { return }
        KingfisherManager.shared.retrieveImage(with: url, options: [.onlyFromCache]) { result in
            switch result {
            case .success(let value):
                completionHandler(value.image)
            case .failure(let error):
                print("Could not get image from cache")
                print(error.localizedDescription)
            }
        }
    }
    
}
