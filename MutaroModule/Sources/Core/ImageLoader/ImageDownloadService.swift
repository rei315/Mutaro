//
//  ImageDownloadService.swift
//  
//
//  Created by minguk-kim on 2023/05/09.
//

import Foundation

public protocol ImageDownloadService {
    associatedtype CacheType
    
    func downloadImage(with urlString: String, cache targetCache: CacheType)
    func cancelDownloadImage(with urlString: String)
}
