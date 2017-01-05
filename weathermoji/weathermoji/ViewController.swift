//
//  ViewController.swift
//  weathermoji
//
//  Created by Andrew Carvajal on 1/4/17.
//  Copyright © 2017 Yuge. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let weather = WeatherGetter()
    @IBOutlet weak var currentLocationNameLabel: UILabel!
    @IBOutlet weak var currentLocationWeatherLabel: UILabel!
    @IBOutlet weak var newYorkWeatherLabel: UILabel!
    @IBOutlet weak var miamiWeatherLabel: UILabel!
    @IBOutlet weak var cairoWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateStaticLocationLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateStaticLocationLabels() {
        weather.updateWeatherID(coordinate: weather.newYorkCoord)
        weather.updateWeatherID(coordinate: weather.miamiCoord)
        weather.updateWeatherID(coordinate: weather.cairoCoord)
        if weather.newYorkID != nil {
            newYorkWeatherLabel.text = weather.weatherEmojis(id: weather.newYorkID!)
        }
        if weather.miamiID != nil {
            miamiWeatherLabel.text = weather.weatherEmojis(id: weather.miamiID!)
        }
        if weather.cairoID != nil {
            cairoWeatherLabel.text = weather.weatherEmojis(id: weather.cairoID!)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationManager.location != nil {
            geocoder.reverseGeocodeLocation(locations[0], completionHandler: { (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        self.currentLocationNameLabel.text = placemark.subLocality ?? placemark.locality
                        if let coord = placemark.location?.coordinate {
                            self.weather.updateWeatherID(coordinate: coord)
                            if self.weather.currentWeatherID != nil {
                                self.currentLocationWeatherLabel.text = self.weather.weatherEmojis(id: self.weather.currentWeatherID!)
                            }
                        } else {
                            print("no coord")
                        }
                    }
                }
            })
            updateStaticLocationLabels()
        }
    }
}

