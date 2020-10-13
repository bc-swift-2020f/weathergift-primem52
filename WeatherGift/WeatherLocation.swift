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
}


//api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=948dbf4236566513916399cdb4283076
