//
//  TabBarContoller.swift
//  forecast
//
//  Created by kpugame on 2016. 6. 6..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class TabBarContoller: UITabBarController {

    
    var Datafile = OpenFile(fileName: "ForecastCityInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Datafile.OpenData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancleToPlayersViewController(segue:UIStoryboardSegue) {
        
    }
}
