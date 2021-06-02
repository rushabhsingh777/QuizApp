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
    func loadImage(fromURL imageUrl: URL, placeHolderImage: String){
            self.image = UIImage(named: placeHolderImage)
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl){
                    if let image = UIImage(data: imageData){
                        DispatchQueue.main.async{
                            self?.image = image
                        }
                    }
                }
            }
        }
}
