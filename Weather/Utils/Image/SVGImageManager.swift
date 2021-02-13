//
//  SVGImageManager.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import Foundation
import SVGKit
class SVGImageManager{
    @InjectCache private var cache: NSCache<NSString, UIImage>
    
    private func getURLWithImageName(name: String) -> URL?{
        return URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(name).svg")
    }
    
    private func downloadSVGImageWithURl(url: URL) -> UIImage?{
        let svgImage = SVGKImage(contentsOf: url)
        return svgImage?.uiImage
    }
}
//MARK: - ImageManager
extension SVGImageManager: ImageManager{
    func getImageWithURL(url: URL) -> UIImage?{
        if let cachedVersion = cache.object(forKey: url.description as NSString){
            return cachedVersion
        } else {
            guard let image = self.downloadSVGImageWithURl(url: url) else { return nil }
            self.cache.setObject(image, forKey: url.description as NSString)
            return image
        }
    }
    
    func getImageWithImageName(name: String) -> UIImage?{
        guard let url = getURLWithImageName(name: name) else { return nil }
        return getImageWithURL(url: url)
    }
    
}
