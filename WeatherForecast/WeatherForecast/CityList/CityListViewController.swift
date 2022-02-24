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
        cell.cityCellImageView.kf.setImage(with: URL(string: "https://listelist.com/wp-content/uploads/2014/12/seattle1-listelist-620x375.jpg"))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityDetails(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
