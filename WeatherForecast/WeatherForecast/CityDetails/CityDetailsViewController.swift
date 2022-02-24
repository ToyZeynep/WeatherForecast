//
//  CityDetailsViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit

protocol CityDetailsDisplayLogic: AnyObject
{
    func displayCityDetails(viewModel: CityDetails.Fetch.ViewModel)
    func presentCityWeather(viewModel: Weather.Fetch.ViewModel)

}

class CityDetailsViewController: UIViewController {
    var interactor: CityDetailsBusinessLogic?
    var router: (CityDetailsRoutingLogic & CityDetailsDataPassing)?
    var viewModel : CityDetails.Fetch.ViewModel?
    var weatherModel: Weather.Fetch.ViewModel?

    // MARK: Object lifecycle

    @IBOutlet weak var cityDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var detailsLabel: UILabel!
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
        let interactor = CityDetailsInteractor(worker: CityDetailsWorker())
        let presenter = CityDetailsPresenter()
        let router = CityDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}

extension CityDetailsViewController :  CityDetailsDisplayLogic{
    func presentCityWeather(viewModel: Weather.Fetch.ViewModel) {
        self.weatherModel = viewModel
        cityDetailsCollectionView.reloadData()
    }
    
    func displayCityDetails(viewModel: CityDetails.Fetch.ViewModel) {
        self.viewModel = viewModel
      
    }
}
