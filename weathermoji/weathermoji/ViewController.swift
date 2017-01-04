//
//  ViewController.swift
//  weathermoji
//
//  Created by Andrew Carvajal on 1/4/17.
//  Copyright © 2017 Yuge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weather = WeatherGetter()
        weather.getWeather(city: "NewYork")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

