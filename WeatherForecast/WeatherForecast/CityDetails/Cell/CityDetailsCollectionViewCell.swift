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
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
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
        cellWindLabel.text = (viewModel.wind_speed?.toString())! + "m/s"
        cellHumidityLabel.text = "%" + (viewModel.humidity?.toString())!
        setImage(status: viewModel.weather_state_name!)
    }
    
    func setImage(status: String){
        cellImageView.image = UIImage(named: status)
    }
    
  
}
