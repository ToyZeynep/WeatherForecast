//
//  CityListViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit
import Kingfisher


protocol CityListDisplayLogic: AnyObject{
    func displayCityList(viewModel: CityList.Fetch.ViewModel)
}

final class CityListViewController: UIViewController {
    
    var interactor: CityListBusinessLogic?
    var router: (CityListRoutingLogic & CityListDataPassing)?
    var viewModel: CityList.Fetch.ViewModel?
    
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var cityListSearcBar: UISearchBar!
    
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
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "CityList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLoader.instance.showLoaderView()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(callme), userInfo: nil, repeats: false)
        ///1. Adım
        interactor?.getLocation()
        cityListTableView.register(UINib(nibName: "CityListTableViewCell", bundle: nil), forCellReuseIdentifier: "CityList")
        hideKeyboardWhenTappedAround()
    }
    
    @objc func callme() {
        CustomLoader.instance.hideLoaderView()
    }
}

// MARK: - Display view model from City List Presenter

extension CityListViewController : CityListDisplayLogic{
    ///4. Adım gelen veriyi ekrana basıyoruz
    func displayCityList(viewModel: CityList.Fetch.ViewModel) {
        self.viewModel = viewModel
        cityListTableView.reloadData()
    }
}

// MARK: - TableView Delegate and DataSource

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cityList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityList", for: indexPath) as! CityListTableViewCell
        guard let model = self.viewModel?.cityList[indexPath.row]  else {
            return UITableViewCell()
        }
        cell.cityNameLabel.text = model.title
        cell.cityCellImageView.kf.setImage(with: URL(string: imagesArr[counter]))
        counter = counter + 1
        favoriCityStatus(button: cell.addFavoritesButton, model: model)
        cell.addFavoritesButton.addTapGesture { [self] in
            
            let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
            if let position = favoriteList.firstIndex(where: {$0.woeid == model.woeid}){
                self.interactor?.deleteFromFavorites(index: position)
                cell.addFavoritesButton.tintColor = .white
            }
            else {
                self.interactor?.addToFavorites(index: indexPath.row)
                cell.addFavoritesButton.tintColor = .red
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func favoriCityStatus(button: UIButton , model: CityList.Fetch.ViewModel.City) {
        let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
        if let position = favoriteList.firstIndex(where: {$0.woeid == model.woeid}){
            button.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .red
        } else {
            button.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .white
        }
    }
}

// MARK: - SearchBar Delegate

extension CityListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(CityListViewController.reload), object: nil)
        self.perform(#selector(CityListViewController.reload), with: nil, afterDelay: 0.7)
    }
    
    @objc func reload() {
        guard let searchText = cityListSearcBar.text else { return }
        ///SearchBar'da anahtar kelime silindiğinde lokasyona göre şehir listesini getiriyoruz
        if searchText == "" {
            self.viewModel?.cityList.removeAll()
            interactor?.getLocation()
            cityListTableView.reloadData()
        } else {
            search(searchText: searchText)
        }
    }
    
    func search(searchText: String){
        ///SearchBar'da aranan şehir ismine göre parametre gönderip isteğimizi atıyoruz.
        var params = [String: Any]()
        params["query"] = searchText
        interactor?.fetchCityList(params: params)
    }
}
