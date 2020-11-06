//
//  VideoData.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 8/25/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import Foundation

class SourceEndPointList: Decodable {
    
    public let sourceEndPoints: [String: SourceEndPoint]
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            sourceEndPoints = try container.decode([String:SourceEndPoint].self)
        } catch (let ee) {
            print(ee)
            sourceEndPoints = [:]
        }
    }
}

extension SourceEndPointList {
    static var all: Resource<SourceEndPointList> = {
        let url = URL(string: "http://root:root@try.axxonsoft.com:8000/asip-api/video-origins")!
        
        return Resource(url: url)
    }()
}

struct SourceEndPoint: Decodable {
    let friendlyNameLong: String
    let friendlyNameShort: String
    let origin: String
    let state: String
}
