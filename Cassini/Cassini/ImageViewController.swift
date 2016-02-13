//
//  ImageViewController.swift
//  Cassini
//
//  Created by abdelrahman mohamed on 2/12/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    
    
    var imageURL: NSURL? {
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    var imageView = UIImageView()
    
    var image:UIImage? {
        get{
            return imageView.image
        }set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinningWheel?.stopAnimating()

        }
    }
    @IBOutlet weak var spinningWheel: UIActivityIndicatorView!
    
    func fetchImage(){
        if let url = imageURL {
            spinningWheel.startAnimating()
            // getting the appropriate queue for the job, it's gonna take long but it's still important for the user.
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)){
                let imageData = NSData(contentsOfURL: url)
                // any UI jobs should be handled back to the main queue, as it's important for user to continue his work on the app.
                dispatch_async(dispatch_get_main_queue()){
                    // checking if the user changed the request link.
                    if url == self.imageURL{
                        if let data = imageData{
                            self.image = UIImage(data: data)
                        }else{
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
   
    
}
