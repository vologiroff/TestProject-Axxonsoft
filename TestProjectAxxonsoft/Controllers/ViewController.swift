//
//  ViewController.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 8/25/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let disposeBag = DisposeBag()
    var sourceEndPoints = [String:SourceEndPoint]()
    
    //The array of fetched videos
    var videosArray: [VideoModel] = []
    //The array of fetched videos (copy)
    var videosArrayCopy: [VideoModel] = []
    
    var selectedVideoIndex: Int!
    
    //Creating views
    lazy var videoTable: UITableView = {
        let v = UITableView(frame: .zero)

        view.addSubview(v)
        v.register(TableViewCellCustom.self, forCellReuseIdentifier: "idCellVideo")
        v.delegate = self
        v.dataSource = self
        
        v.rowHeight = 140.0
        
        return v
    }()
    
    lazy var searchBar: UISearchBar = {
        let s = UISearchBar(frame: .zero)
        
        view.addSubview(s)
        
        return s
    }()
    
    lazy var viewWait: UIView = {
        let v = UIView(frame: .zero)
        
        view.addSubview(v)
        
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWait.isHidden = true
        
        setupConstraints()
        populateSourceEndPoints()
    }


    //MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idCellVideo", for: indexPath)
        
        setupCell(cell: cell, index: indexPath)
        
        return cell
    }
    
    func setupCell(cell: UITableViewCell, index: IndexPath) {
        let cellVideoTitle = cell.viewWithTag(10) as! UILabel
        let cellVideoThumbnail = cell.viewWithTag(11) as! UIImageView
        
        //Check for a long name
        if videosArray[index.row].friendlyNameLong != nil && videosArray[index.row].friendlyNameLong != "" {
            cellVideoTitle.text = videosArray[index.row].friendlyNameLong
        } else {
            cellVideoTitle.text = videosArray[index.row].friendlyNameShort
        }
        
        cellVideoThumbnail.image = videosArray[index.row].img
    }
    
    
    //MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoIndex = indexPath.row
        
        let ZC = ZoomViewController()
        
        ZC.videoFetched = videosArray[selectedVideoIndex]
        
        present(ZC, animated: true, completion: nil)
        
        videoTable.deselectRow(at: indexPath, animated: true)
    }
    
}
