//
//  CityDetailsModels.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit

enum CityDetails{
    
    enum Fetch{
        
        struct Response{
            
            let city: CityListResponse?
        }
        
        struct ViewModel{
            
            let title : String?
        }
    }
}

enum Weather{
    
    enum Fetch{
        
        struct Response{
            
            let weatherDetails: [WeatherDetails]
        }
        
        struct ViewModel{
            
            var weatherDetails: [Weather.Fetch.ViewModel.WeatherDetails]
            
            struct WeatherDetails {
                
                let weather_state_name : String?
                let applicable_date : String?
                let min_temp : Double?
                let max_temp : Double?
                let the_temp : Double?
                let wind_speed : Double?
                let wind_direction : Double?
                let air_pressure : Double?
                let humidity : Int?
                
            }
        }
    }
}

