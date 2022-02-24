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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchCityList(params: [String: Any] ){
        //getWeather
        
        self.worker?.getCityList(params: params) {[weak self] result in
            switch result {
            case .success(let response):
                self?.cityList = response
                guard let cityList = self?.cityList else { return }
                self?.presenter?.presentCityList(response: CityList.Fetch.Response(cityList:cityList))
            case .failure(let error): break
                //error
            }
        }
    }
}

extension CityListInteractor: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        coordinates = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        var params: [String: Any] = [String: Any]()
        params["lattlong"] = coordinates
        fetchCityList(params: params)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
