//
//  PlayerViewController.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 8/25/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
    
    var labelView: UILabel!
    var imageView: UIImageView!
    
    var labelText: String = ""
    var image: UIImage?
    
    override func viewDidLoad() {
        labelView.text = labelText
        
        setupView(view: imageView, num: 0.035)
        imageView.image = image
    }
    
    func setupView(view: UIView, num: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = num * view.layer.bounds.size.width
    }
}
