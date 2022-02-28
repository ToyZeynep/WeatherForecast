//
//  CityListPresenter.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit

protocol CityListPresentationLogic: AnyObject {
    func presentCityList(response: CityList.Fetch.Response)
    func presentAlert(title: String , message: String)
    func presentAlertAction(title: String , message: String , action: UIAlertAction)
}

final class CityListPresenter: CityListPresentationLogic {
    
    weak var viewController: CityListDisplayLogic?
    ///3. Adım gelen listeyi viewmodeldeki listemize atıp view controllera  ekrana basılmak üzere gönderiyoruz
    func presentCityList(response: CityList.Fetch.Response) {
        var cityList: [CityList.Fetch.ViewModel.City] = []
        response.cityList.forEach {
            cityList.append(CityList.Fetch.ViewModel.City(distance: $0.distance, title: $0.title, location_type: $0.location_type, woeid: $0.woeid, latt_long: $0.latt_long))
        }
        ///doldurduğumuz listeyi viewController a parametre olarak gönderiyoruz
        viewController?.displayCityList(viewModel: CityList.Fetch.ViewModel(cityList: cityList))
    }
    
    func presentAlert(title: String , message: String){
        Alert.alert(title: title , message: message)
    }
    
    func presentAlertAction(title: String , message: String , action: UIAlertAction) {
        Alert.alertAction(title: title, message: message, action: action)
    }
}

