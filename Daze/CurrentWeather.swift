//
//  CurrentWeather.swift
//  Daze
//
//  Created by Cory Billeaud on 8/28/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _day: String!
    var _time: String!
    var _weatherType: String!
    var _longDescription: String!
    var _icon: String!
    var _currentTemp: String!
    var _tempMax: String!
    var _tempMin: String!
    var _windSpeed: String!
    var _windDirection: WindDirection!
    var _sunrise: String!
    var _sunset: String!
    var _country: String!
    var _humidity: String!
    var _rain: String!
    
    enum WindDirection {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SSW
        case SW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }

    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "\(currentDate)"
        return _date
    }
    
    var day: String {
        if _day == nil {
            _day = ""
        }
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .full
        dayFormatter.dateFormat = "EEEE"
        dayFormatter.timeStyle = .none
        return _day
    }
    
    var time: String {
        if _time == nil {
            _time = ""
        }
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        return _time
    }
    
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var longDescription: String {
        if _longDescription == nil {
            _longDescription = ""
        }
        return _longDescription
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var tempMax: String {
        if _tempMax == nil {
            _tempMax = ""
        }
        return _tempMax
    }
    
    var tempMin: String {
        if _tempMin == nil {
            _tempMin = ""
        }
        return _tempMin
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
//    var windDirection: WindDirection {
//        get {
//            return _windDirection
//        }
//    }
    
    var windDirection: WindDirection {
        if _windDirection == nil {
            _windDirection = WindDirection.N
        }
            return _windDirection
    }
    
    var sunrise: String {
        if _sunrise == nil {
            _sunrise = ""
        }
        return _sunrise
    }
    
    var sunset: String {
        if _sunset == nil {
            _sunset = ""
        }
        return _sunset
    }
    
    var country: String {
        if _country == nil {
            _country = ""
        }
        return _country
    }
    
    var rain: String {
        if _rain == nil {
            _rain = "0.0"
        }
        return _rain
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
    //Alamofire download
        Alamofire.request(CURRENT_WEATHER_URL, method: .get).responseJSON { response in
            //every response has a result
            let result = response.result
            //print(response) checking for url response in json data
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let dt = dict["dt"] as? Double {
                    let date = Date(timeIntervalSince1970: dt)
                    let dayFormatter = DateFormatter()
                    let dateFormatter = DateFormatter()
                    let timeFormatter = DateFormatter()
                    dayFormatter.dateFormat = "EEEE"
                    dateFormatter.dateStyle = DateFormatter.Style.long
                    timeFormatter.dateFormat = "h:mm MM/dd"
                    self._day = dayFormatter.string(from: date)
                    self._date = dateFormatter.string(from: date)
                    self._time = timeFormatter.string(from: date)
                    
                }

                
                if let name = dict["name"] as? String {
                    self._cityName = name.uppercased()
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.uppercased()
                    }
                    
                    if let description = weather[0]["description"] as? String {
                        self._longDescription = description.uppercased()
                    }
                    
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                    }
                }
                
                if  let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        self._currentTemp = String(format: "%.0f", temp) as String
                    }
                    
                    if let maxTemp = main["temp_max"] as? Double {
                        self._tempMax = String(format: "%.0f", maxTemp) as String
                    }
                    
                    if let minTemp = main["temp_min"] as? Double {
                        self._tempMin = String(format: "%.0f", minTemp) as String
                    }
                    
                    if let humid = main["humidity"] as? Double {
                        self._humidity = String(format: "%.0f", humid) as String
                    }
                    
                }
                
                if let rain = dict["rain"] as? Dictionary<String, AnyObject> {
                    if let precip = rain["3h"] as? String {
                        self._rain = String(format: "%.1f", precip) as String
                    }
                }
                
                if let windDetails = dict["wind"] as? Dictionary<String, AnyObject> {
                    
                        if let speed = windDetails["speed"] as? Double {
                            self._windSpeed = String(format: "%.0f", speed) as String as String
                    }
                    
                    if let direc = windDetails["deg"] as? Double {
                        switch (direc) {
                        case 348.75...360:
                            self._windDirection = WindDirection.N
                        case 0..<11.25:
                            self._windDirection = WindDirection.N
                        case 11.25..<33.75:
                            self._windDirection = WindDirection.NNE
                        case 33.75..<56.25:
                            self._windDirection = WindDirection.NE
                        case 56.25..<78.75:
                            self._windDirection = WindDirection.ENE
                        case 78.75..<101.25:
                            self._windDirection = WindDirection.E
                        case 101.25..<123.75:
                            self._windDirection = WindDirection.ESE
                        case 123.75..<146.25:
                            self._windDirection = WindDirection.SE
                        case 146.25..<168.75:
                            self._windDirection = WindDirection.SSE
                        case 168.75..<191.25:
                            self._windDirection = WindDirection.S
                        case 191.25..<213.75:
                            self._windDirection = WindDirection.SSW
                        case 213.75..<236.25:
                            self._windDirection = WindDirection.SW
                        case 236.25..<258.75:
                            self._windDirection = WindDirection.WSW
                        case 258.75..<281.25:
                            self._windDirection = WindDirection.W
                        case 281.25..<303.75:
                            self._windDirection = WindDirection.WNW
                        case 303.75..<326.25:
                            self._windDirection = WindDirection.NW
                        case 326.25..<348.75:
                            self._windDirection = WindDirection.NNW
                        default:
                            self._windDirection = WindDirection.N
                    
                        }
                
                    }
                }
                
                if let sysDetl = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunrise = sysDetl["sunrise"] as? Double {
                        let date = Date(timeIntervalSince1970: sunrise)
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "h:mma"
                        self._sunrise = timeFormatter.string(from: date)
                    }
                    
                    if let sunset = sysDetl["sunset"] as? Double {
                        let date = Date(timeIntervalSince1970: sunset)
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "h:mma"
                        self._sunset = timeFormatter.string(from: date)
                    }
                    
                    if let country = sysDetl["country"] as? String {
                        self._country = country.uppercased()
                    }
                }
                
            }

            
                completed()
        
        }
    }

}

