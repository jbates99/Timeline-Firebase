//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Joshua Bates on 6/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //imageView
    
    func updateWithImageIdentifier(identifier: String) {
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            // self.imageView.image = image
        }
    }
}