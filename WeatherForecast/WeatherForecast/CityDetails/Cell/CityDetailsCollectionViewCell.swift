//
//  CityDetailsCollectionViewCell.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit
import Kingfisher

class CityDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellHumidityLabel: UILabel!
    @IBOutlet weak var cellWindLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTempLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 8, left: 4, bottom: 4, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.systemMint.cgColor
        contentView.backgroundColor = .clear
        contentView.layer.borderWidth = 0.5
        contentView.clipsToBounds = true
   
    }
    
    func configure(viewModel: Weather.Fetch.ViewModel.WeatherDetails){
        cellTempLabel.text = (viewModel.the_temp?.toString())! +  "°"
        cellDateLabel.text = viewModel.applicable_date
        cellWindLabel.text = "Wind: " + (viewModel.wind_speed?.toString())! + " m/s"
        cellHumidityLabel.text = "Humidity: %" + (viewModel.humidity?.toString())!
        setImage(status: viewModel.weather_state_name!)
        let dateFormatter = DateFormatter(format: "yyyy-MM-dd")
        cellDateLabel.text = viewModel.applicable_date?.toDateString(dateFormatter: dateFormatter, outputFormat: "dd MMMM")
        weekDayLabel.text = viewModel.applicable_date?.toDateString(dateFormatter: dateFormatter, outputFormat: "EEEE")
    }
    
    func setImage(status: String){
        switch status {
        case WeatherStatus.snow.rawValue : cellImageView.image = UIImage(named: "snow")
        case WeatherStatus.sleet.rawValue : cellImageView.image = UIImage(named: "sleet")
        case WeatherStatus.hail.rawValue : cellImageView.image = UIImage(named: "hail")
        case WeatherStatus.thunderstorm.rawValue : cellImageView.image = UIImage(named: "thunder")
        case WeatherStatus.showers.rawValue : cellImageView.image = UIImage(named: "showers")
        case WeatherStatus.heavyRain.rawValue : cellImageView.image = UIImage(named: "heavyRain")
        case WeatherStatus.lightRain.rawValue : cellImageView.image = UIImage(named: "lightRain")
        case WeatherStatus.heavyCloud.rawValue : cellImageView.image = UIImage(named: "heavyCloud")
        case WeatherStatus.lightCloud.rawValue : cellImageView.image = UIImage(named: "lightCloud")
        case WeatherStatus.clear.rawValue : cellImageView.image = UIImage(named: "clear")
        default: break
        }
    }
}
