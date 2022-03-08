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
    func fetchFavoriteList()
}

protocol FavoriteListDataStore: AnyObject {
    var favoriteList:[CityListResponse]? { get set }
}

final class FavoriteListInteractor: FavoriteListBusinessLogic, FavoriteListDataStore{
    var favoriteList: [CityListResponse]?
    var presenter: FavoriteListPresentationLogic?
    var worker: FavoriteListWorkingLogic?
 
    
    
    func deleteFromFavorites(index: Int){
        let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
        if let position = favoriteList.firstIndex(where: {$0.woeid == favoriteList[index].woeid}){
            RealmHelper.sharedInstance.deleteFromDb(city: favoriteList[position])
        }
    }
    
    
    func fetchFavoriteList(){
        
        let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
        var list:[CityListResponse] = [CityListResponse]()
        list.append(contentsOf: favoriteList)
        self.favoriteList = list
        self.presenter?.presentFavoriteList(response: FavoriteList.Fetch.Response(favoriteList: self.favoriteList!))
    }
}
