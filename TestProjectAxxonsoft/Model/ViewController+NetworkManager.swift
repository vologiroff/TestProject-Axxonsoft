//
//  ViewController+URLRequest.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/10/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit
import RxSwift

let disposeBag = DisposeBag()

extension ViewController {
    
    func populateSourceEndPoints() {
        
        URLRequest.load(resource: SourceEndPointList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.sourceEndPoints = result.sourceEndPoints
                    
                    self?.videosArray.removeAll()
                    self?.videosArrayCopy.removeAll()
                    
                    //Creating video with thumbnails arrays
                    for key in result.sourceEndPoints.values {
                        let videoModel = VideoModel()
                        videoModel.friendlyNameLong = key.friendlyNameLong
                        videoModel.friendlyNameShort = key.friendlyNameShort
                        videoModel.state = key.state
                        videoModel.imgURL = "http://root:root@try.axxonsoft.com:8000/asip-api/live/media/snapshot/\(key.origin)"
                        
                        self?.videosArray.append(videoModel)
                        self?.videosArrayCopy.append(videoModel)
                    }
                    
                    self?.videosArray = (self?.videosArrayCopy.sorted{$0.friendlyNameLong! < $1.friendlyNameLong!})!
                    
                    DispatchQueue.main.async {
                        self?.videoTable.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func loadVideoSnap(for imageUrl: String) {
        
        DispatchQueue.main.async { [self] in
            imageToCache.setObject(UIImage(named: "loadingImage")!, forKey: NSString(string: imageUrl))
            videoTable.reloadData()
        }
        
        URLRequest.loadImage(resource: URL(string: imageUrl)!)
            .subscribe(onNext: { image in
                DispatchQueue.main.async { [self] in
                    guard let downloadedImage = image else {
                        imageToCache.setObject(#imageLiteral(resourceName: "Image"), forKey: NSString(string: imageUrl))
                        videoTable.reloadData()
                        return
                    }
                    
                    imageToCache.setObject(downloadedImage, forKey: NSString(string: imageUrl))
                    videoTable.reloadData()
                }
                
            }).disposed(by: disposeBag)
        
    }
    
}
