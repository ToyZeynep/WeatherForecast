//
//  ViewExtension.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit
extension UIView {
    
    func dropShadow() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.purple.cgColor
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropViewShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowColor = UIColor.purple.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
