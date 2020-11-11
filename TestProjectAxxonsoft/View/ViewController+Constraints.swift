//
//  ViewController+Constraints.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/9/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit
import SnapKit

extension ViewController {
    
    func setupConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview().labeled("searchBarWidth")
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).labeled("searchBarTop")
            make.centerX.equalToSuperview().labeled("searchBarCenterX")
        }
        
        videoTable.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}
