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
}

protocol CityListDataPassing: AnyObject {
    var dataStore: CityListDataStore? { get }
}

class CityListRouter: CityListRoutingLogic, CityListDataPassing {
    weak var viewController: CityListViewController?
    var dataStore: CityListDataStore?
 
    func routeToCityDetails(index: Int) {
    let storyBoard = UIStoryboard(name: "CityDetails", bundle: nil)
    let destVC: CityDetailsViewController = storyBoard.instantiateViewController(identifier: "CityDetails")
    // data passing sample
    var currentCity = dataStore?.cityList?[index]
    destVC.router?.dataStore?.woeid = currentCity!.woeid
    destVC.modalPresentationStyle = .fullScreen
    self.viewController?.present(destVC, animated: true, completion: nil)
    }
}
