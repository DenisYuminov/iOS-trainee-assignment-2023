//
//  ImageService.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import Foundation
import UIKit


protocol IImageService: AnyObject {
    func loadImage(fromURL urlString: String, completion: @escaping (UIImage?) -> Void)
}

class ImageService: IImageService {
    static let shared = ImageService()
    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}

    func loadImage(fromURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else if let imageURL = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: urlString as NSString)
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
