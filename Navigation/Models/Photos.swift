//
//  Photos.swift
//  Navigation
//
//  Created by iAlesha уличный on 13.05.2023.
//

import UIKit

struct Photos {
    static func getPhotos() -> [UIImage] {
        
        var imagesArray = [UIImage]()
        for i in 1...20 {
            let imageName = "IMG\(i)"
            if let image = UIImage(named: imageName) {
                imagesArray.append(image)
            }
        }
        return imagesArray
    }

}

