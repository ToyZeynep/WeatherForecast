//
//  FavoriteListTableViewCell.swift
//  WeatherForecast
//
//  Created by MacOS on 8.03.2022.
//

import UIKit

class FavoriteListTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteFavoritesButton: UIButton!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 0.7
        contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
