//
//  DetailViewController.swift
//  forecast
//
//  Created by kpugame on 2016. 6. 6..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel2: UILabel!
    @IBOutlet weak var detailDescriptionLabel3: UILabel!
   
    
    var detailCity: CityData? {
        didSet {
            detailDescriptionLabel.text = detailCity?.Do
            detailDescriptionLabel2.text = detailCity?.Si
            detailDescriptionLabel3.text = detailCity?.Dong
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
