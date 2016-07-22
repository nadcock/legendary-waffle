//
//  PhotoCollectionViewCell.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    var imageView = UIImageView()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func prepareForReuse() {
        imageView.removeFromSuperview()
        spinner.startAnimating()
    }
    
    func setupView() {
        addSubview(spinner)
        
        // Center horizontally
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[spinner]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["superview":self, "spinner":spinner])
        
        addConstraints(constraints)
        
        // Center vertically
        constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[superview]-(<=1)-[spinner]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: ["superview":self, "spinner":spinner])
        
        addConstraints(constraints)
        spinner.startAnimating()
        
    }
    
    internal func setDownloadedImage(image: UIImage) {
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[imageView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["imageView":imageView])
        
        addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[imageView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["imageView":imageView])
        
        addConstraints(constraints)
        spinner.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}