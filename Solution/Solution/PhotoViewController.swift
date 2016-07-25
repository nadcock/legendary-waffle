//
//  PhotoViewController.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    var photo: Photo?
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(photo!.title!)"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[imageView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["imageView":imageView])
        
        view.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[imageView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["imageView":imageView])
        
        view.addConstraints(constraints)
        
        imageView.contentMode = .ScaleAspectFit
        
        API.sharedInstance.downloadPhoto(photo!.url!) { (downloadedPhoto: NSData) -> Void in
            let processedImage = UIImage(data: downloadedPhoto)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = processedImage!
            }
        }
        
    }
    
}