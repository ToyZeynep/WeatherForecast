//
//  FavoritesViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 7.03.2022.
//

import Foundation
import UIKit
import Kingfisher

protocol FavoriteListDisplayLogic: AnyObject{
    func displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel)
}

final class FavoriteListViewController: UIViewController {
    
    var interactor: FavoriteListBusinessLogic?
    var router: (FavoriteListRoutingLogic & FavoriteListDataPassing)?
    var viewModel: FavoriteList.Fetch.ViewModel?
    
    let imagesArr = [URLString.image0.rawValue , URLString.image16.rawValue ,URLString.image1.rawValue ,URLString.image2.rawValue,URLString.image3.rawValue, URLString.image12.rawValue, URLString.image4.rawValue,URLString.image5.rawValue,URLString.image6.rawValue,  URLString.image13.rawValue ,URLString.image7.rawValue,URLString.image8.rawValue , URLString.image9.rawValue, URLString.image10.rawValue , URLString.image11.rawValue, URLString.image14.rawValue , URLString.image15.rawValue]
    var timer = Timer()
    var counter = 0{
        didSet{
            if counter == 17{
                counter = 0
            }else{
                
            }
        }
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = FavoriteListInteractor()
        let presenter = FavoriteListPresenter()
        let router = FavoriteListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "FavoriteList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLoader.instance.showLoaderView()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(callme), userInfo: nil, repeats: false)
    }
    
    @objc func callme() {
        CustomLoader.instance.hideLoaderView()
    }
}

// MARK: - Display view model from City List Presenter

extension FavoriteListViewController : FavoriteListDisplayLogic{
    ///4. Adım gelen veriyi ekrana basıyoruz
    func displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
