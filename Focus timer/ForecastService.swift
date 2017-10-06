//
//  ForecastService.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/6/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation

class ForecastService
{
    let forecastAPIKey: String
    let forecastBaseURL: URL?
    
    init(APIKey: String) {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getForecast(latitude: Double, longtitude: Double, completion: @escaping (CurrentWeather?) -> Void)
    {
        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longtitude)")
        {
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : Any]{
                    let currenWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currenWeather)
                }else{
                    completion(nil)
                }
            })
        }
    }
}
