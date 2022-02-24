//
//  CityListViewController.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit
import Kingfisher


protocol CityListDisplayLogic: AnyObject
{
    func displayCityList(viewModel: CityList.Fetch.ViewModel)
}

final class CityListViewController: UIViewController {
    
    var interactor: CityListBusinessLogic?
    var router: (CityListRoutingLogic & CityListDataPassing)?
    var viewModel: CityList.Fetch.ViewModel?
    
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var cityListSortButton: UIButton!
    @IBOutlet weak var cityListSearcBar: UISearchBar!
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "CityList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       interactor?.getLocation()
        cityListTableView.register(UINib(nibName: "CityListTableViewCell", bundle: nil), forCellReuseIdentifier: "CityList")
    }
    
    @IBAction func cityListSortButtonTapped(_ sender: Any) {
    }
}

extension CityListViewController : CityListDisplayLogic{
    
    func displayCityList(viewModel: CityList.Fetch.ViewModel) {
        self.viewModel = viewModel
        cityListTableView.reloadData()
    }
}

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
        let randomNumber = Int.random(in: 0...3)
        let imagesArr = [URLString.image0.rawValue ,URLString.image1.rawValue ,URLString.image2.rawValue,URLString.image3.rawValue,URLString.image4.rawValue,URLString.image5.rawValue,URLString.image6.rawValue,URLString.image7.rawValue,URLString.image8.rawValue , URLString.image9.rawValue]
             
        cell.cityCellImageView.kf.setImage(with: URL(string: imagesArr[indexPath.row] ))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityDetails(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func setImage(index: Int , imageView: UIImageView){
     
        }
    }


extension CityListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(CityListViewController.reload), object: nil)
        self.perform(#selector(CityListViewController.reload), with: nil, afterDelay: 0.7)
    }
    
    @objc func reload() {
        guard let searchText = cityListSearcBar.text else { return }
        if searchText == "" {
            self.viewModel?.cityList.removeAll()
            interactor?.getLocation()
            cityListTableView.reloadData()
        } else {
            search(searchText: searchText)
        }
    }
    
    func search(searchText: String){
        var params = [String: Any]()
        params["query"] = searchText
        interactor?.fetchCityList(params: params)
        
    }
}
