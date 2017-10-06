//
//  CurrentWeather.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/6/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation

class CurrentWeather
{
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    
    struct WeatherKey {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summary = "summary"
    }
    init(weatherDictionary: [String : Any]) {
        temperature = weatherDictionary[WeatherKey.temperature] as? Int
        
        if let humidityDouble = weatherDictionary[WeatherKey.humidity] as? Double {
            humidity = Int(humidityDouble*100)
        }else{
            humidity = nil
        }
        
        if let precipDouble = weatherDictionary[WeatherKey.precipProbability] as? Double {
            precipProbability = Int(precipDouble*100)
        }else{
            precipProbability = nil
        }
        summary = weatherDictionary[WeatherKey.summary] as? String
    }
}
