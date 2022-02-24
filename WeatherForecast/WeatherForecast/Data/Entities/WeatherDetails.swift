//
//  WeatherDetails.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
struct WeatherDetails : Codable {
    let id : Int?
    let weather_state_name : String?
    let weather_state_abbr : String?
    let wind_direction_compass : String?
    let created : String?
    let applicable_date : String?
    let min_temp : Double?
    let max_temp : Double?
    let the_temp : Double?
    let wind_speed : Double?
    let wind_direction : Double?
    let air_pressure : Double?
    let humidity : Int?
    let visibility : Double?
    let predictability : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case weather_state_name = "weather_state_name"
        case weather_state_abbr = "weather_state_abbr"
        case wind_direction_compass = "wind_direction_compass"
        case created = "created"
        case applicable_date = "applicable_date"
        case min_temp = "min_temp"
        case max_temp = "max_temp"
        case the_temp = "the_temp"
        case wind_speed = "wind_speed"
        case wind_direction = "wind_direction"
        case air_pressure = "air_pressure"
        case humidity = "humidity"
        case visibility = "visibility"
        case predictability = "predictability"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        weather_state_name = try values.decodeIfPresent(String.self, forKey: .weather_state_name)
        weather_state_abbr = try values.decodeIfPresent(String.self, forKey: .weather_state_abbr)
        wind_direction_compass = try values.decodeIfPresent(String.self, forKey: .wind_direction_compass)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        applicable_date = try values.decodeIfPresent(String.self, forKey: .applicable_date)
        min_temp = try values.decodeIfPresent(Double.self, forKey: .min_temp)
        max_temp = try values.decodeIfPresent(Double.self, forKey: .max_temp)
        the_temp = try values.decodeIfPresent(Double.self, forKey: .the_temp)
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
        wind_direction = try values.decodeIfPresent(Double.self, forKey: .wind_direction)
        air_pressure = try values.decodeIfPresent(Double.self, forKey: .air_pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
        predictability = try values.decodeIfPresent(Int.self, forKey: .predictability)
    }

}

