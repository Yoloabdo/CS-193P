//
//  MediaCollectionViewCell.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 3/7/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!{
        didSet{
            loadingImage.startAnimating()
            loadingImage.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    var dataTask: NSURLSessionDataTask?

}
