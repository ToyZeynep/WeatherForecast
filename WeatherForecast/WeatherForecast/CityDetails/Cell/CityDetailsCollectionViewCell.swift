//
//  CityDetailsCollectionViewCell.swift
//  WeatherForecast
//
//  Created by MacOS on 24.02.2022.
//

import UIKit

class CityDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var testLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 8, left: 4, bottom: 4, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.yellow
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.clipsToBounds = true
    }
    
}
