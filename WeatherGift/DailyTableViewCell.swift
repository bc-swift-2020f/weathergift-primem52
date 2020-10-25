//
//  DailyTableViewCell.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/25/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyImageView: UIImageView!
    
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    @IBOutlet weak var dailySummaryLabel: UITextView!
    
    var dailyWeather: DailyWeather! {
        didSet {
            dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
            dailyWeekdayLabel.text = dailyWeather.dailyWeekday
            dailyHighLabel.text = "\(dailyWeather.dailyHigh)°"
            dailySummaryLabel.text = dailyWeather.dailySummary
            dailyLowLabel.text = "\(dailyWeather.dailyLow)°"
        }
    }
}
