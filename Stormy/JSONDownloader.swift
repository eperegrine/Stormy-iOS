//
//  JSONDownloader.swift
//  Stormy
//
//  Created by Emily Peregrine on 11/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

class JSONDownloader {
    let session: URLSession
    
    init(config: URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, DarkSkyError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonParsingError)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnnsucceful(satusCode: httpResponse.statusCode))
            }
        }
        
        return task
    }
}
