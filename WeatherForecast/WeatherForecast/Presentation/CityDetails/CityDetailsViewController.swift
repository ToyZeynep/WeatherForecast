//
//  CityDetailsViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit
import Kingfisher
import SwiftGifOrigin

protocol CityDetailsDisplayLogic: AnyObject{
    func presentCityWeather(viewModel: Weather.Fetch.ViewModel)
    func presentCityTitle(viewModel: CityDetails.Fetch.ViewModel)
}

class CityDetailsViewController: UIViewController {
    var interactor: CityDetailsBusinessLogic?
    var router: (CityDetailsRoutingLogic & CityDetailsDataPassing)?
    ///Title için kullandığımız model
    var viewModel: CityDetails.Fetch.ViewModel?
    ///Hava durmu detayları listesi için kullandığımız model
    var weatherModel: Weather.Fetch.ViewModel?
    var gridFlowLayout = GridFlowLayout()
    var timer = Timer()
    
    @IBOutlet weak var cityDetailsImageView: UIImageView!
    @IBOutlet weak var cityDetailsCollectionView: UICollectionView!
    @IBOutlet weak var cityDetailsTitleLabel: UILabel!
    @IBOutlet weak var cityDetailsWindSpeedLabel: UILabel!
    @IBOutlet weak var cityDetailsHumidityLabel: UILabel!
    @IBOutlet weak var cityDetailsWeekDayLabel: UILabel!
    @IBOutlet weak var cityDetailsTempLabel: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLoader.instance.showLoaderView()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(callme), userInfo: nil, repeats: false)
        ///1. Adım
        interactor?.fetchCityDetails()
        cityDetailsCollectionView.collectionViewLayout = gridFlowLayout
        let nib = UINib(nibName: "CityDetailsCollectionViewCell", bundle: nil)
        cityDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "detailsCell")
    }
    
    @objc func callme() {
        CustomLoader.instance.hideLoaderView()
    }
}

// MARK: - Display view model from City Details Presenter

extension CityDetailsViewController :  CityDetailsDisplayLogic{
    ///4. Adım gelen verileri ekrana basıyoruz
    
    func presentCityTitle(viewModel: CityDetails.Fetch.ViewModel) {
        self.viewModel = viewModel
        cityDetailsTitleLabel.text = viewModel.title
    }
    
    func presentCityWeather(viewModel: Weather.Fetch.ViewModel) {
        self.weatherModel = viewModel
        cityDetailsCollectionView.reloadData()
        selectDay(index: 0)
    }
    
    func selectDay(index: Int ){
        var model =  self.weatherModel?.weatherDetails[index]
        self.cityDetailsHumidityLabel.text = "%" + (model?.humidity?.toString())!
        self.cityDetailsWindSpeedLabel.text = (model?.wind_speed?.toString())! + ("m/s")
        self.cityDetailsTempLabel.text = ((model?.the_temp!.toString())!) + "°C"
        setGif(status: (model?.weather_state_name)!)
        let dateFormatter = DateFormatter(format: "yyyy-MM-dd")
        cityDetailsWeekDayLabel.text = model?.applicable_date!.toDateString(dateFormatter: dateFormatter, outputFormat: "EEEE")
    }
    
    func setGif(status: String ){
        switch status {
        case WeatherStatus.snow.rawValue : cityDetailsImageView.loadGif(asset: "snowGif")
        case WeatherStatus.sleet.rawValue : cityDetailsImageView.loadGif(asset: "sleetGif")
        case WeatherStatus.hail.rawValue : cityDetailsImageView.loadGif(asset: "hailGif")
        case WeatherStatus.thunderstorm.rawValue : cityDetailsImageView.loadGif(asset: "thunderGif")
        case WeatherStatus.showers.rawValue : cityDetailsImageView.loadGif(asset: "showersGif")
        case WeatherStatus.heavyRain.rawValue : cityDetailsImageView.loadGif(asset: "heavyRainGif")
        case WeatherStatus.lightRain.rawValue : cityDetailsImageView.loadGif(asset: "lightRainGif")
        case WeatherStatus.heavyCloud.rawValue : cityDetailsImageView.loadGif(asset: "heavyCloudGif")
        case WeatherStatus.lightCloud.rawValue : cityDetailsImageView.loadGif(asset: "lightCloudGif")
        case WeatherStatus.clear.rawValue : cityDetailsImageView.loadGif(asset: "clearGif")
        default: break
        }
    }
}

// MARK: - CollectionView DataSource

extension CityDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.weatherDetails.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! CityDetailsCollectionViewCell
        let model = (self.weatherModel?.weatherDetails[indexPath.item])!
        cell.configure(viewModel: model)
        //did select item methodu çalışmadığı için cell'e tap gesture ekledim.seçilen gün ekrana basılacak
        cell.addTapGesture { [self] in
            selectDay(index: indexPath.item )
        }
        return cell
    }
}

