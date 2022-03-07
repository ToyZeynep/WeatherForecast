//
//  FavoriteListRouter.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit

protocol FavoriteListRoutingLogic: AnyObject {
    func routeToCityDetails(index: Int)
}

protocol FavoriteListDataPassing: AnyObject {
    var dataStore: FavoriteListDataStore? { get }
}

class FavoriteListRouter: FavoriteListRoutingLogic, FavoriteListDataPassing {
    weak var viewController: FavoriteListViewController?
    var dataStore: FavoriteListDataStore?
    
    func routeToCityDetails(index: Int) {
        let storyBoard = UIStoryboard(name: "CityDetails", bundle: nil)
        let destVC: CityDetailsViewController = storyBoard.instantiateViewController(identifier: "CityDetails")
        ///detaylar sayfasına iki ayrı değer göndermemiz gerekiyor (woeid ve title) bunun için city modelimizi gönderiyoruz.
        destVC.router?.dataStore?.city =  dataStore?.favoriteList?[index]
        destVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
}

