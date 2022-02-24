//
//  CityDetailsRouter.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit

@objc protocol CityDetailsRoutingLogic {

}

protocol CityDetailsDataPassing {
    var dataStore: CityDetailsDataStore? { get }
}

class CityDetailsRouter: NSObject, CityDetailsRoutingLogic, CityDetailsDataPassing {
    weak var viewController: CityDetailsViewController?
    var dataStore: CityDetailsDataStore?

}
