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
    
    @IBOutlet weak var favoriteListTableView: UITableView!
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        self.navigationController?.navigationBar.tintColor = UIColor.red
        let image = UIImage(named: "delete")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -4, right: -3)
    }
    
    @objc func addTapped(){
      
        RealmHelper.sharedInstance.deleteAllFromDatabase()
        self.interactor?.fetchFavoriteList()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchFavoriteList()
        CustomLoader.instance.showLoaderView()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(callme), userInfo: nil, repeats: false)
        favoriteListTableView.register(UINib(nibName: "FavoriteListTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteListCell")
    }
    
    @objc func callme() {
        CustomLoader.instance.hideLoaderView()
    }
}

// MARK: - Display view model from City List Presenter

extension FavoriteListViewController : FavoriteListDisplayLogic{
    
    func displayFavoriteList(viewModel: FavoriteList.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.favoriteList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteListCell", for: indexPath) as! FavoriteListTableViewCell
        guard let model = self.viewModel?.favoriteList[indexPath.row]  else {
            return UITableViewCell()
        }
        cell.cityTitleLabel.text = model.title
        cell.cityImageView.kf.setImage(with: URL(string: imagesArr[counter]))
        counter = counter + 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        viewModel?.favoriteList.remove(at: indexPath.row)
        self.favoriteListTableView.deleteRows(at: [indexPath], with: .automatic)
        self.interactor?.deleteFromFavorites(index: indexPath.row)
    }
    
    func favoriCityStatus(button: UIButton , model: FavoriteList.Fetch.ViewModel.City) {
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
