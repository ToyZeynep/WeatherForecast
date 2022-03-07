//
//  CityListInteractor.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import Foundation
import UIKit
import CoreLocation

protocol CityListBusinessLogic: AnyObject {
    func fetchCityList(params: [String: Any])
    func getLocation()
    func addToFavorites(index: Int)
    func deleteFromFavorites(index: Int)
}

protocol CityListDataStore: AnyObject {
    var cityList:[CityListResponse]? { get set }
}

final class CityListInteractor: NSObject ,CityListBusinessLogic, CityListDataStore{
    var locationManager = CLLocationManager()
    var coordinates: String?
    var presenter: CityListPresentationLogic?
    var worker: CityListWorkingLogic?
    var cityList:[CityListResponse]?
    
    init(worker: CityListWorkingLogic) {
        self.worker = worker
    }
    
    func getLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        checkLocationPermission()
    }
    
    
    func addToFavorites(index: Int){
        RealmHelper.sharedInstance.addCityToFavorites(city: (cityList?[index])!)
    }
    
    func deleteFromFavorites(index: Int){
        let favoriteList = RealmHelper.sharedInstance.fetchFavoriteList().map { $0 }
        if let position = favoriteList.firstIndex(where: {$0.woeid == cityList?[index].woeid}){
            RealmHelper.sharedInstance.deleteFromDb(city: favoriteList[position])
        }
    }
        func checkLocationPermission() {
            switch self.locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                locationManager.requestLocation()
            case .denied, .restricted:
                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }
                presenter?.presentAlertAction(title: "Error!", message: "Share your location information for a better experience", action: settingsAction)
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            @unknown default:
                fatalError()
            }
        }
        
        func fetchCityList(params: [String: Any] ){
            ///2. Adım
            self.worker?.getCityList(params: params) {[weak self] result in
                switch result {
                case .success(let response):
                    self?.cityList = response
                    guard let cityList = self?.cityList else { return }
                    ///gelen response'u oluşturduğumuz listeye aktarıyoruz ve parametre olarak presenter a gönderiyoruz
                    self?.presenter?.presentCityList(response: CityList.Fetch.Response(cityList:cityList))
                case .failure(let error):
                    self?.presenter?.presentAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    extension CityListInteractor: CLLocationManagerDelegate{
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation :CLLocation = locations[0] as CLLocation
            let lat = userLocation.coordinate.latitude
            let long = userLocation.coordinate.longitude
            coordinates = "\(lat),\(long)"
            var params: [String: Any] = [String: Any]()
            ///parametre oluşturulup isteğimizi atıyoruz
            params["lattlong"] = coordinates
            fetchCityList(params: params)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location Error: ", error)
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationPermission()
        }
    }
