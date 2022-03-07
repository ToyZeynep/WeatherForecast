//
//  FavoriteListInteractor.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit

protocol FavoriteListBusinessLogic: AnyObject {
    
    func deleteFromFavorites(index: Int)
}

protocol FavoriteListDataStore: AnyObject {
    var favoriteList:[CityListResponse]? { get set }
}

final class FavoriteListInteractor: FavoriteListBusinessLogic, FavoriteListDataStore{
    var favoriteList: [CityListResponse]?
    var presenter: FavoriteListPresentationLogic?
    var worker: FavoriteListWorkingLogic?
    var cityList:[CityListResponse]?
    
    
    func deleteFromFavorites(index: Int){
        let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
        if let position = favoriteList.firstIndex(where: {$0.woeid == cityList?[index].woeid}){
            RealmHelper.sharedInstance.deleteFromDb(city: favoriteList[position])
        }
    }
    
    
    func fetchFavoriteList(params: [String: Any] ){
    
    }
}
