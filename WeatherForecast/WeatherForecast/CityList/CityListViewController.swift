//
//  CityListViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit


protocol CityListDisplayLogic: AnyObject
{
    func displayCityList(viewModel: CityList.Fetch.ViewModel)
}

final class CityListViewController: UIViewController {
    
    var interactor: CityListBusinessLogic?
    var router: (CityListRoutingLogic & CityListDataPassing)?
    var viewModel: CityList.Fetch.ViewModel?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = CityListInteractor(worker: CityListWorker())
        let presenter = CityListPresenter()
        let router = CityListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension CityListViewController : CityListDisplayLogic{

    func displayCityList(viewModel: CityList.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}


