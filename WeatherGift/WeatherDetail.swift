//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/13/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import Foundation


class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]

    }
    
    struct Weather: Codable {
        var description: String
        var icon: String
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIKeys.openWeatherKey)"
        print("Were accessing url \(urlString)")
        
        guard let url = URL(string: urlString) else{
            print("Couldnt make url")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url){(data, response, error) in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("Result: \(result)")
                print("The timezone for \(self.name) is \(result.timezone)")
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = result.current.weather[0].icon
            }
            catch{
                print("Json error \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
