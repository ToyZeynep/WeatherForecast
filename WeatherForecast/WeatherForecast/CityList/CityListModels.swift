//
//  CityListModels.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit

enum CityList
{
    
    enum Fetch
    {
        struct Response{
            
            var cityList : [CityListResponse]
        }
        
        struct ViewModel{
            
            var cityList: [CityList.Fetch.ViewModel.City]
            
            struct City {
                
                let distance : Int?
                let title : String?
                let location_type : String?
                let woeid : Int?
                let latt_long : String?
                
            }
        }
    }
}

