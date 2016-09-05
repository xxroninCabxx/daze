//
//  Location.swift
//  Daze
//
//  Created by Cory Billeaud on 8/30/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
