//
//  WeatherCell.swift
//  project00
//
//  Created by moktaesu on 2016. 6. 12..
//  Copyright © 2016년 Sabi Park. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
