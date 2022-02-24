//
//  CityDetailsInteractor.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit

protocol CityDetailsBusinessLogic {
    func fetchCityDetails()
}

protocol CityDetailsDataStore: class {
    var city: CityDetailsResponse? { get set }
    var woeid: Int? { get set }
    var weatherDetails: [WeatherDetails]?  { get set }
}

class CityDetailsInteractor: CityDetailsBusinessLogic, CityDetailsDataStore {
    
    var city: CityDetailsResponse?
    var woeid: Int?
    var weatherDetails: [WeatherDetails]?
    var presenter: CityDetailsPresentationLogic?
    var worker: CityDetailsWorkingLogic
    
    init(worker: CityDetailsWorkingLogic) {
        self.worker = worker
    }
    
    
    
    func fetchCityDetails(){
        let param: Int = woeid!
        let params: String = String(param)
        self.worker.getCityDetails(params: params){[weak self] result in
            switch result {
            case .success(let response):
                self?.city = response
                self?.weatherDetails = response.weatherDetails
                guard let weatherDetails = self?.weatherDetails else {
                    return
                }
                guard let city = self?.city else { return }
                self?.presenter?.presentCityDetails(response: CityDetails.Fetch.Response(city: city))
                self?.presenter?.presentCityWeather(response: Weather.Fetch.Response(weatherDetails: weatherDetails))
               case .failure(let error): break
                //error
            }
        }
    }
}
