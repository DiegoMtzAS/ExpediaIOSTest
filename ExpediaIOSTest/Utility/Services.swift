//
//  Services.swift
//  ExpediaIOSTest
//
//  Created by Diego Martinez on 09/11/23.
//

import Foundation
class Services{
    
    /**
     Get City Weather
     - returns: City
     */
    class func getCityWeather(city: String, onResult: @escaping (Result<City>) -> Void){
        let endpoint = Endpoint(city: city)
        let url = NetworkManager.shared.getURL(path: endpoint)
        let request = NetworkManager.formRequest(url: url, method: .get)
        NetworkManager.request(request: request, onResult: onResult)
    }
}
