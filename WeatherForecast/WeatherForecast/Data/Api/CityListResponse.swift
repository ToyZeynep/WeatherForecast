//
//  CityListResponse.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import RealmSwift

 class CityListResponse: Object , Codable {
    
    
    @objc dynamic var title : String?
    @objc dynamic var location_type : String?
    @objc dynamic var woeid = 0
    @objc dynamic var latt_long : String?

    enum CodingKeys: String, CodingKey {

      
        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
    }
}
