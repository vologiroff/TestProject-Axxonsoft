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
            //        make.height.equalTo(56).labeled("timerHeight")
            make.top.equalToSuperview().labeled("searchBarTop")
            make.centerX.equalToSuperview().labeled("searchBarCenterX")
        }
        
        videoTable.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        viewWait.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
        }
        
        cellImage.snp.makeConstraints { make in
            make.leading.equalTo(cellLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(120)
        }
    }
    
}
