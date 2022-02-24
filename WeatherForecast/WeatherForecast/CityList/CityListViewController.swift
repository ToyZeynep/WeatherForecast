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
        //self.navigationController?.navigationBar.isHidden = true
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
        
        setImage(index: indexPath.row, imageView: cell.cityCellImageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityDetails(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func setImage(index: Int , imageView: UIImageView){
        switch index {
        case 0:
            imageView.kf.setImage(with: URL(string: "https://listelist.com/wp-content/uploads/2014/12/seattle1-listelist-620x375.jpg"))
        case 1:
            imageView.kf.setImage(with: URL(string: "https://www.webtekno.com/images/editor/default/0002/44/d91091ba1036af6bcd708fba6514035a59c54c80.jpeg"))
        case 2:
            imageView.kf.setImage(with: URL(string: "https://blog-biletall.mncdn.com/wp-content/uploads/2015/11/kiz-kulesi-istanbul.jpg"))
        case 3:
            imageView.kf.setImage(with: URL(string: "https://2.bp.blogspot.com/-ipl3SSQIHJQ/WtjvgT0wWrI/AAAAAAAADFs/9au1QxhMHoU6QTgeRr8lsWxtvzsmeXdzQCLcBGAs/s1600/tokyo4.jpg"))
        case 4:
            imageView.kf.setImage(with: URL(string: "https://media-cdn.t24.com.tr/media/library/2019/02/1549032671414-109328.jpg"))
        case 5:
            imageView.kf.setImage(with: URL(string: "https://i0.wp.com/thegeyik.com/wp-content/uploads/2015/02/Hong-Kong.jpg"))
        case 6:
            imageView.kf.setImage(with: URL(string:"https://static9.depositphotos.com/1010683/1238/i/600/depositphotos_12384660-stock-photo-singapore-city-skyline-at-night.jpg"))
        case 7:
            imageView.kf.setImage(with: URL(string: "https://listelist.com/wp-content/uploads/2014/12/seattle1-listelist-620x375.jpg"))
        case 9:
            imageView.kf.setImage(with: URL(string: "https://im.haberturk.com/2019/11/15/ver1573819707/2540687_1024x576.jpg"))
        case 10:
            imageView.kf.setImage(with: URL(string: "https://pixabay.com/photos/buildings-city-illuminated-1804481/"))
       
        default:
            break
        }
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
