//
//  ImageDownloadService.swift
//
//
//  Created by minguk-kim on 2023/05/09.
//

import Foundation
import Kingfisher

public protocol ImageDownloadService {
    func downloadImage(with urlString: String, cache targetCache: ImageCache)
    func cancelDownloadImage(with urlString: String)
}
