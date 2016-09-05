//
//  Forecast.swift
//  Daze
//
//  Created by Cory Billeaud on 8/29/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _hiTemp: String!
    var _loTemp: String!
    var _icon: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var hiTemp: String {
        if _hiTemp == nil {
            _hiTemp = ""
        }
        return _hiTemp
    }
    var loTemp: String {
        if _loTemp == nil {
            _loTemp = ""
        }
        return _loTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._loTemp = "\(kelvinToFarenheit)"
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._hiTemp = "\(kelvinToFarenheit)"
                
            }
            
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
            
            if let icon = weather[0]["icon"] as? String {
                self._icon = icon
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
}
