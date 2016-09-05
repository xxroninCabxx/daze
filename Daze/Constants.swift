//
//  Constants.swift
//  lookOutWeather
//
//  Created by Cory Billeaud on 8/10/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import Foundation
import UIKit

// Request url format for current conditions (Bragg City, MO - 63827)
// http://api.openweathermap.org/data/2.5/weather?zip=63827,us&units=imperial&appid=d69ffb7363aa3aec20c923612d701a11
// http://api.openweathermap.org/data/2.5/forecast?id=4418478,us&units=imperial&appid=d69ffb7363aa3aec20c923612d701a11

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "d69ffb7363aa3aec20c923612d701a11"
let URL_UNITS = "&units=imperial"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=imperial&appid=d69ffb7363aa3aec20c923612d701a11"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=d69ffb7363aa3aec20c923612d701a11"


let SHADOW_COLOR: CGFloat = 157.0 / 255.0




