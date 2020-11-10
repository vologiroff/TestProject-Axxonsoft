//
//  ViewController+URLRequest.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/10/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit

extension ViewController {
    
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
                                self?.videosArrayCopy.append(videoModel)
                                self?.videosArray = (self?.videosArrayCopy.sorted{$0.friendlyNameLong! < $1.friendlyNameLong!})!
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
                    self?.videosArrayCopy.append(video)
                    self?.videosArray = (self?.videosArrayCopy.sorted{$0.friendlyNameLong! < $1.friendlyNameLong!})!
                    self?.videoTable.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
}
