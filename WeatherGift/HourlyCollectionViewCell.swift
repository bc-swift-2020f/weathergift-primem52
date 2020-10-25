//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/25/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourlyTemperature: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var hourlyWeather: HourlyWeather! {
           didSet {
            hourLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon) 
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
        }
    }
    
    
}
