//
//  FavoriteListPresenter.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit

protocol FavoriteListPresentationLogic: AnyObject {
    func presentFavoriteList(response: FavoriteList.Fetch.Response)
    func presentAlert(title: String , message: String)
    func presentAlertAction(title: String , message: String , action: UIAlertAction)
}

final class FavoriteListPresenter: FavoriteListPresentationLogic {
    
    weak var viewController: FavoriteListDisplayLogic?
   
    func presentFavoriteList(response: FavoriteList.Fetch.Response) {
        var favoriteList: [FavoriteList.Fetch.ViewModel.City] = []
        response.favoriteList.forEach {
            favoriteList.append(FavoriteList.Fetch.ViewModel.City( title: $0.title, location_type: $0.location_type, woeid: $0.woeid, latt_long: $0.latt_long))
        }
        ///doldurduğumuz listeyi viewController a parametre olarak gönderiyoruz
        viewController?.displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel(favoriteList: favoriteList))
    }
    
    func presentAlert(title: String , message: String){
        Alert.alert(title: title , message: message)
    }
    
    func presentAlertAction(title: String , message: String , action: UIAlertAction) {
        Alert.alertAction(title: title, message: message, action: action)
    }
}

