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
    var gridFlowLayout = GridFlowLayout()
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
        interactor?.fetchCityDetails()
        cityDetailsCollectionView.collectionViewLayout = gridFlowLayout
        let nib = UINib(nibName: "CityDetailsCollectionViewCell", bundle: nil)
        cityDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "detailsCell")
    }
}

extension CityDetailsViewController :  CityDetailsDisplayLogic{
    func presentCityWeather(viewModel: Weather.Fetch.ViewModel) {
        self.weatherModel = viewModel
        cityDetailsCollectionView.reloadData()
    }
    
    func displayCityDetails(viewModel: CityDetails.Fetch.ViewModel) {
        self.viewModel = viewModel
        detailsLabel.text = viewModel.title
      
    }
}

extension CityDetailsViewController: UICollectionViewDataSource {
   
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.weatherDetails.count ?? 0
       
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! CityDetailsCollectionViewCell
        let model = self.weatherModel?.weatherDetails[indexPath.item]
        cell.testLabel.text = model?.weather_state_name
        return cell
    }
}

