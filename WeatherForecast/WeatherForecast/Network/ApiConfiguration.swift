//
//  ApiConfiguration.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//


import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
