//
//  PlayerViewController.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 8/25/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
    
    lazy var labelView: UILabel = {
        let l = UILabel(frame: .zero)
        
        l.textAlignment = .center
        
        view.addSubview(l)
        
        return l
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView(frame: .zero)
    
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        
        view.addSubview(v)
        
        return v
    }()
    
    lazy var friendlyNameLong = String()
    lazy var friendlyNameShort = String()
    lazy var image = UIImage()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
        
        setup()
        setupConstraints()
    }
    
    func setup() {
        
        if friendlyNameLong != "" {
            labelView.text = friendlyNameLong
        } else {
            labelView.text = friendlyNameShort
        }
        
        imageView.image = image
    }
    
}
