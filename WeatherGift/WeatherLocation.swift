//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/12/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData(){
        let urlString = "api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIKeys.openWeatherKey)"
        print("Were accessing url \(urlString)")
        
        guard let url = URL(string: urlString) else{
            print("Couldnt make url")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url){(data, response, error) in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("yo \(json)")
            }
            catch{
                print("Json error \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}


//api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=948dbf4236566513916399cdb4283076
