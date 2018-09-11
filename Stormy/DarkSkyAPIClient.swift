//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Emily Peregrine on 11/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    fileprivate let darkSkyApiKey = "9a3278cae9c904930ca972c225a570e0"
    
    lazy var baseUrl: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias WeatherCompletionHandler = (Weather?, DarkSkyError?) -> Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void
    
    private func getWeather(at coord: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler ) {
        guard let url = URL(string: coord.description, relativeTo: baseUrl) else {
            completion(nil, DarkSkyError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            guard let json = json else {
                completion(nil, error)
                return
            }
            guard let weather = Weather(json: json) else {
                completion(nil, .jsonParsingError)
                return
            }
            completion(weather, nil)
        }
        
        task.resume()
    }
    
    func getCurrentWeather(at coord: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getWeather(at: coord) {
            weather, error in
            completion(weather?.currently, nil)
        }
    }
}
