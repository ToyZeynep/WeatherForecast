//
//  FavoriteListPresenter.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit

protocol FavoriteListPresentationLogic: AnyObject {
    
    func presentAlert(title: String , message: String)
    func presentAlertAction(title: String , message: String , action: UIAlertAction)
}

final class FavoriteListPresenter: FavoriteListPresentationLogic {
    
    weak var viewController: FavoriteListDisplayLogic?
   
    
    func presentAlert(title: String , message: String){
        Alert.alert(title: title , message: message)
    }
    
    func presentAlertAction(title: String , message: String , action: UIAlertAction) {
        Alert.alertAction(title: title, message: message, action: action)
    }
}

