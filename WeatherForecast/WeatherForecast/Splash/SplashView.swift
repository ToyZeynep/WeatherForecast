//
//  SplashView.swift
//  WeatherForecast
//
//  Created by MacOS on 26.02.2022.
//

import Foundation
import UIKit
import SwiftGifOrigin

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        splashImageView.loadGif(asset: "seasons")
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        splashImageView.contentMode = .scaleAspectFit
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
            let storyBoard = UIStoryboard(name: "CityList", bundle: nil)
            let destVC: CityListViewController = storyBoard.instantiateViewController(identifier: "CityList")
            destVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}
