//
//  URLRequest+Extensions.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 10/25/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
//                print(String(data: data, encoding: .utf8))
                return try? JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
    
    static func loadImage(resource: URL) -> Observable<UIImage?> {
        return Observable.from(optional: resource)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> UIImage? in
                return UIImage(data: data)
            }.asObservable()
    }
}
