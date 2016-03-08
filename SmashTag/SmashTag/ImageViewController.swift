//
//  ImageViewController.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 3/8/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.contentSize = imageView.frame.size // critical to set this!
            scrollView.delegate = self                    // required for zooming
            scrollView.minimumZoomScale = 0.03            // required for zooming
            scrollView.maximumZoomScale = 1.0             // required for zooming
        }

    }
    
    private var imageView = UIImageView()
    
    // UIScrollViewDelegate method
    // required for zooming
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.addSubview(imageView)
    }



   
}
