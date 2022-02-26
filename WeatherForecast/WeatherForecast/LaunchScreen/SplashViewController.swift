//
//  SplashViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 25.02.2022.
//

import UIKit
import SwiftGifOrigin

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashImageView.loadGif(asset: "splash")
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            let storyBoard = UIStoryboard(name: "CityList", bundle: nil)
            let destVC: CityListViewController = storyBoard.instantiateViewController(identifier: "CityList")
            destVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}
