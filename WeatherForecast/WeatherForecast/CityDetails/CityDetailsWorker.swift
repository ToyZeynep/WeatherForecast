//
//  CityDetailsWorker.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

protocol CityDetailsWorkingLogic: AnyObject {
    func getCityDetails(params: String, completion: @escaping ((Result<CityDetailsResponse, Error>)-> Void))
}

final class CityDetailsWorker: CityDetailsWorkingLogic {
    
    func getCityDetails(params: String, completion: @escaping ((Result<CityDetailsResponse, Error>)-> Void)){
        ApiClient.request(ApiEndPoint.cityDetails(params: params)) {(_ result: Result<CityDetailsResponse, Error>) in
            completion(result)
        }
    }
}


