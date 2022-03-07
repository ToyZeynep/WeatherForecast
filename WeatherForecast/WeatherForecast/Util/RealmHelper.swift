//
//  RealmHelper.swift
//  WeatherForecast
//
//  Created by MacOS on 5.03.2022.
//

import Foundation
import Realm
import RealmSwift

class RealmHelper {
    
    private var   database:Realm
    static let   sharedInstance = RealmHelper()
    
    private init() {
        database = try! Realm()
    }
    
    func addCityToFavorites(city: CityListResponse) {
        try! database.write {
          //  database.add(city)
            database.create(CityListResponse.self, value: city)
        }
    }
    
    func fetchFavoriteList() -> Results<CityListResponse> {
        let object = database.objects(CityListResponse.self)
        return object;
    }
    
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(city: CityListResponse)   {
    
        try! database.write {
            database.delete(city)
        }
    }
}
