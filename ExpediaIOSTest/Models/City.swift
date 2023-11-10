//
//  City.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import Foundation
struct City: Codable, Hashable {
    
    let location: Location
    let current: Current
    
    enum CodingKeys: String, CodingKey {
        case location, current
    }
    
    init(location: Location, current: Current) {
        self.location = location
        self.current = current
    }
}

struct Location: Codable, Hashable {
    let name, region, country, tz_id, localtime: String
    let lat, lon: Double
    let localtime_epoch: Int
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, tz_id, localtime, lat, lon,localtime_epoch
    }
}

struct Current: Codable, Hashable{
    let last_updated_epoch, is_day, wind_degree , humidity, cloud, vis_km, vis_miles, uv: Int
    let last_updated, wind_dir: String
    let temp_c, temp_f, wind_mph, wind_kph, pressure_in, pressure_mb, feelslike_c, feelslike_f, gust_mph, gust_kph, precip_mm, precip_in: Double
    let condition: Condition
    
    enum CodingKeys: Codable, CodingKey{
        case last_updated_epoch, is_day, wind_degree, pressure_mb, precip_mm, precip_in, humidity, cloud, vis_km, vis_miles, uv, last_updated, wind_dir, temp_c, temp_f, wind_mph, wind_kph, pressure_in, feelslike_c, feelslike_f, gust_mph, gust_kph, condition
    }
}

struct Condition: Codable, Hashable {
    let text, icon: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case text, icon, code
    }
}
