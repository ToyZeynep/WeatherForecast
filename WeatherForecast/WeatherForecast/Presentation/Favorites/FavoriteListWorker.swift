//
//  FavoriteListWorker.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//


import UIKit
import Realm
import RealmSwift

protocol FavoriteListWorkingLogic: AnyObject {
    func fetchFavoriteList() -> Results<CityListResponse>
    func deleteAllFromDatabase()
    func deleteFromDb(city: CityListResponse)
}

final class FavoriteListWorker: FavoriteListWorkingLogic {
    
    private var   database:Realm
    static let   sharedInstance = FavoriteListWorker()
    
    private init() {
        database = try! Realm()
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






