//
//  CityListResponse.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
struct CityListResponse: Codable {
    
    let distance : Int?
    let title : String?
    let location_type : String?
    let woeid : Int?
    let latt_long : String?

    enum CodingKeys: String, CodingKey {

        case distance = "distance"
        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
    }

}

