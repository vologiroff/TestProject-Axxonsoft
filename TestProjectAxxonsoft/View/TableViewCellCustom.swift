//
//  TableViewCellCustom.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/9/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {
    
    let cellLabel: UILabel = {
        let lbl = UILabel(frame: .zero)

        lbl.tag = 10
        
        return lbl
    }()

    let cellImage: UIImageView = {
        let img = UIImageView()
        
        img.clipsToBounds = true
        img.layer.cornerRadius = 10

        img.tag = 11
        
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cellLabel)
        addSubview(cellImage)
        
        setupCellConstraints()
    }
    
    func setupCellConstraints() {
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
