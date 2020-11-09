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
    
//    @IBOutlet weak var videoTable: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var viewWait: UIView!
    
    private let disposeBag = DisposeBag()
    private var sourceEndPoints = [String:SourceEndPoint]()
    
    var videosArray: [VideoModel] = []
    //The same array only for the data filtrating
    var backupVideoArray: [VideoModel] = []
    
    var selectedVideoIndex: Int!
    
    //Creating views
    lazy var videoTable: UITableView = {
        let v = UITableView(frame: .zero)
        
        view.addSubview(v)

        v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        v.delegate = self
        v.dataSource = self
        
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
    
    lazy var cellLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        
        lbl.tag = 10
        
        return lbl
    }()
    
    lazy var cellImage: UIImageView = {
        let img = UIImageView(frame: .zero)
        
        img.tag = 11
        
        return img
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWait.isHidden = true
        
//        setupConstraints()
        populateSourceEndPoints()
    }


    //MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idCellVideo", for: indexPath)
        videoTable.rowHeight = 160.0
        
        cell.addSubview(cellLabel)
        cell.addSubview(cellImage)
        
        setupConstraints()
        
        let videoTitle = cell.viewWithTag(10) as! UILabel
        let videoThumbnail = cell.viewWithTag(11) as! UIImageView
        
        //Check for a long name
        if videosArray[indexPath.row].friendlyNameLong != nil && videosArray[indexPath.row].friendlyNameLong != "" {
            videoTitle.text = videosArray[indexPath.row].friendlyNameLong
        } else {
            videoTitle.text = videosArray[indexPath.row].friendlyNameShort
        }
        
        setupView(view: videoThumbnail, num: 0.035)
        videoThumbnail.image = videosArray[indexPath.row].img
        
        return cell
    }
    
    func setupView(view: UIView, num: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = num * view.layer.bounds.size.width
    }
    
    //MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoIndex = indexPath.row
        performSegue(withIdentifier: "idViewControllerPlayerView", sender: self)
        
        videoTable.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idViewControllerPlayerView" {
            let playerViewController = segue.destination as! PlayerViewController
            
            if videosArray[selectedVideoIndex].friendlyNameLong != nil && videosArray[selectedVideoIndex].friendlyNameLong != "" {
                playerViewController.labelText = videosArray[selectedVideoIndex].friendlyNameLong!
            } else {
                playerViewController.labelText = videosArray[selectedVideoIndex].friendlyNameShort
            }
            playerViewController.image = videosArray[selectedVideoIndex].img
        }
    }
    
    //MARK: - NetworkManager
    
    func populateSourceEndPoints() {
        
        URLRequest.load(resource: SourceEndPointList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.sourceEndPoints = result.sourceEndPoints
                    
                    //Creating video with thumbnails arrays
                    for key in result.sourceEndPoints.values {
                        let videoModel = VideoModel()
                        videoModel.friendlyNameLong = key.friendlyNameLong
                        videoModel.friendlyNameShort = key.friendlyNameShort
                        videoModel.origin = key.origin
                        videoModel.imgURL = "http://root:root@try.axxonsoft.com:8000/asip-api/live/media/snapshot/\(key.origin)"
                        
                        
                        if videoModel.origin != "signal_lost" {
                            DispatchQueue.global().async {
                                self?.loadVideoSnap(for: videoModel)
                            }
                        } else {
                            DispatchQueue.main.async {
                                videoModel.img = #imageLiteral(resourceName: "Image")
                                self?.videosArray.append(videoModel)
                                self?.backupVideoArray.append(videoModel)
                                self?.videosArray = (self?.backupVideoArray.sorted{$0.friendlyNameLong! < $1.friendlyNameLong!})!
                                self?.videoTable.reloadData()
                            }
                            
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    
    func loadVideoSnap(for video: VideoModel) {
        
        var imageToAppend = UIImage()
        
        URLRequest.loadImage(resource: URL(string: video.imgURL)!)
            .subscribe(onNext: { [weak self] image in
                DispatchQueue.main.async {
                    if let image = image {
                        imageToAppend = image
                    } else {
                        imageToAppend = #imageLiteral(resourceName: "Image")
                    }
                    
                    video.img = imageToAppend
                    self?.videosArray.append(video)
                    self?.backupVideoArray.append(video)
                    self?.videosArray = (self?.backupVideoArray.sorted{$0.friendlyNameLong! < $1.friendlyNameLong!})!
                    self?.videoTable.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
}
    
    //MARK: - Search Bar Methods
    
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        videosArray = backupVideoArray.filter({
            $0.friendlyNameShort.contains(searchBar.text!)
        })
        
        if(searchBar.text?.count == 0) {
            videosArray = backupVideoArray
        }
        
        videoTable.reloadData()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            videosArray = backupVideoArray
        
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            videosArray = backupVideoArray.filter({
                $0.friendlyNameShort.contains(searchBar.text!)
            })
        }
        
        videoTable.reloadData()
    }
}

