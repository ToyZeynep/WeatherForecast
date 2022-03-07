//
//  FavoriteListViewModel.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit

enum FavoriteList{
    
    enum Fetch{
        
        struct Response{
            
            var favoriteList : [CityListResponse]
        }
        
        struct ViewModel{
            
            var favoriteList: [CityList.Fetch.ViewModel.City]
            
            struct City {
                
                let title : String?
                let location_type : String?
                let woeid : Int?
                let latt_long : String?
            }
        }
    }
}

