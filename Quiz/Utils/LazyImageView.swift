//
//  LazyImageView.swift
//  Quiz
//
//  Created by Rushabh Singh on 02/06/21.
//

import Foundation
import UIKit

class LazyImageView: UIImageView
{
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromURL imageUrl: URL, placeHolderImage: String){
        if let cachedImage = self.imageCache.object(forKey: imageUrl as AnyObject){
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        }else{
            self.image = UIImage(named: placeHolderImage)
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl){
                    if let image = UIImage(data: imageData){
                        DispatchQueue.main.async{
                            self?.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
