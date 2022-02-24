//
//  CityDetailsResponse.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
struct CityDetailsResponse : Codable {
    let weatherDetails : [WeatherDetails]?
    let time : String?
    let sun_rise : String?
    let sun_set : String?
    let timezone_name : String?
    let title : String?
    let location_type : String?
    let woeid : Int?
    let latt_long : String?
    let timezone : String?

    enum CodingKeys: String, CodingKey {

        case weatherDetails = "consolidated_weather"
        case time = "time"
        case sun_rise = "sun_rise"
        case sun_set = "sun_set"
        case timezone_name = "timezone_name"
        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
        case timezone = "timezone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weatherDetails = try values.decodeIfPresent([WeatherDetails].self, forKey: .weatherDetails)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        sun_rise = try values.decodeIfPresent(String.self, forKey: .sun_rise)
        sun_set = try values.decodeIfPresent(String.self, forKey: .sun_set)
        timezone_name = try values.decodeIfPresent(String.self, forKey: .timezone_name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }

}

