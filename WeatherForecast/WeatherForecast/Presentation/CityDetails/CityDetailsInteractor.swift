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

protocol CityDetailsDataStore: AnyObject {
    var city: CityListResponse? { get set }
    var weatherDetails: [WeatherDetails]?  { get set }
}

class CityDetailsInteractor: CityDetailsBusinessLogic, CityDetailsDataStore {
    var city: CityListResponse?
    var weatherDetails: [WeatherDetails]?
    var presenter: CityDetailsPresentationLogic?
    var worker: CityDetailsWorkingLogic
    
    init(worker: CityDetailsWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCityDetails(){
        ///2. Adım City Listten gelen woeid parametre olarak veriyoruz.
        let param: Int = (city?.woeid)!
        let params: String = String(param)
        self.worker.getCityDetails(params: params){[weak self] result in
            switch result {
            case .success(let response):
                self?.weatherDetails = response.weatherDetails
                guard let weatherDetails = self?.weatherDetails else {
                    return
                }
                guard let city = self?.city else{
                    return
                }
                ///Hava durumu detaylarını WeatherDetails responsuna cast edip parametre olarak presenter'a gönderiyoruz.
                self?.presenter?.presentCityWeather(response: Weather.Fetch.Response(weatherDetails: weatherDetails))
                ///Api'de City details' da city title verisi  bulunmadığı için cityListten gönderdiğimiz city modelini , oluşturduğumuz responsa cast ediyoruz.
                self?.presenter?.presentCityTitle(response: CityDetails.Fetch.Response(city: city))
            case .failure(let error):
                self!.presenter?.presentAlert(title: "Error!", message: error.localizedDescription)
            }
        }
    }
}
