//
//  CityListRouter.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit

protocol CityListRoutingLogic: AnyObject {
    func routeToCityDetails(index: Int)
    func routeToFavorites()
}

protocol CityListDataPassing: AnyObject {
    var dataStore: CityListDataStore? { get }
}

class CityListRouter: CityListRoutingLogic, CityListDataPassing {
    func routeToFavorites() {
        let storyBoard = UIStoryboard(name: "FavoriteList", bundle: nil)
        let destVC: FavoriteListViewController = storyBoard.instantiateViewController(identifier: "FavoriteList")
        destVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    

    
    weak var viewController: CityListViewController?
    var dataStore: CityListDataStore?
    
    func routeToCityDetails(index: Int) {
        let storyBoard = UIStoryboard(name: "CityDetails", bundle: nil)
        let destVC: CityDetailsViewController = storyBoard.instantiateViewController(identifier: "CityDetails")
        ///detaylar sayfasına iki ayrı değer göndermemiz gerekiyor (woeid ve title) bunun için city modelimizi gönderiyoruz.
        destVC.router?.dataStore?.city =  dataStore?.cityList?[index]
        destVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
}
