//
//  ApiEndPoints.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import Alamofire

enum ApiEndPoint: APIConfiguration {
    
    case cityList(params: [String: Any])
    case cityDetails(params: String)
    
    var cityUrl : String {
        return "api/location/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .cityList:
            return .get
        case .cityDetails:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .cityList:
            return cityUrl + "search/"
        case .cityDetails(let params):
            ///woeid parametre olarak alınıyor. tipi [String: Any] olmadığı için String  path olarak aldım.
            return cityUrl + params
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .cityList(let params):
            return params
        case .cityDetails:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try "https://www.metaweather.com/".asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Parameters
        let encoding: ParameterEncoding = {
            switch method {
            case .post:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
        
    }
}

