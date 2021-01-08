//
//  WeatherForcecastDc.swift
//  Weather
//
//  Created by Ta Huy Hung on 4/2/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//

import Foundation

struct ResponseData {
    var main : [WFMain]?
    var name : String?
}

struct WFMain {
    var temp : String?
}

