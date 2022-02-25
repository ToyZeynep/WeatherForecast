//
//  StringExtension.swift
//  WeatherForecast
//
//  Created by MacOS on 25.02.2022.
//

import Foundation


extension Double {
    func toString() -> String {
        return String(format: "%.2f",self)
    }
}

extension Int
{
    func toString() -> String
    {
        var myString = String(self)
        return myString
    }
}
