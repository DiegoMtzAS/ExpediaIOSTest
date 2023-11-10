//
//  Endpoint.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import Foundation
struct Endpoint {
    
    let basePath = "https://api.weatherapi.com/v1/current.json?key=9745357b64764a1c926173930223105&q="
    var city: String = ""
    let basePathCompletion = "&aqi=no"
    
    init(city: String) {
        self.city = city
    }
    
    var absoluteURL: String {
        self.basePath + self.city + self.basePathCompletion
    }

}
