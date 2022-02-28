//
//  ApiClient.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import Alamofire

class ApiClient {

    static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> Void) {
        print(urlConvertible.urlRequest)
       AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
           print(response.response)
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
                Alert.alert(title: "Error!", message: error.localizedDescription)
            }
        }
    }
}
