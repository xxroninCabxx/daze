//
//  WeatherCell.swift
//  Daze
//
//  Created by Cory Billeaud on 8/30/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var hiTempLbl: UILabel!
    @IBOutlet weak var loTempLbl: UILabel!
    
    func configureCell(forecast: Forecast) {
        loTempLbl.text = "\(forecast.loTemp)"
        hiTempLbl.text = "\(forecast.hiTemp)"
        weatherTypeLbl.text = forecast.weatherType.uppercased()
        dayLbl.text = forecast.date.uppercased()
        weatherIcon.image = UIImage(named: forecast._icon)
    }

   

    
}
