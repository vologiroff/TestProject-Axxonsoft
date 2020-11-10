//
//  ZoomViewController+Constraints.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/10/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit
import SnapKit

extension ZoomViewController {
    
    func setupConstraints() {
      
        labelView.snp.makeConstraints { make in
            make.width.equalToSuperview().labeled("labelViewBarWidth")
            make.top.equalToSuperview().offset(50).labeled("labelViewTop")
            make.centerX.equalToSuperview().labeled("labelViewCenterX")
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalTo(labelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().labeled("imageViewCenterX")
        }
        
    }
    
}
