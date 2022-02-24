//
//  CityListRouter.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit

protocol CityListRoutingLogic: AnyObject {
   
}

protocol CityListDataPassing: AnyObject {
    var dataStore: CityListDataStore? { get }
}

class CityListRouter: CityListRoutingLogic, CityListDataPassing {
    weak var viewController: CityListViewController?
    var dataStore: CityListDataStore?
 
}
