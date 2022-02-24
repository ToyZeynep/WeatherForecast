//
//  CityListWorker.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit

protocol CityListWorkingLogic: AnyObject {
    func getCityList(params: [String: Any], completion: @escaping ((Result<[CityListResponse], Error>) -> Void))
}

final class CityListWorker: CityListWorkingLogic {
    func getCityList(params: [String: Any], completion: @escaping ((Result<[CityListResponse], Error>) -> Void)) {
        ApiClient.request(ApiEndPoint.cityList(params: params)) {(_ result: Result<[CityListResponse], Error>) in
            completion(result)
        }
    }
}



