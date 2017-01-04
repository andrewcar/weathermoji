//
//  WeatherGetter.swift
//  weathermoji
//
//  Created by Andrew Carvajal on 1/4/17.
//  Copyright © 2017 Yuge. All rights reserved.
//

import Foundation
import MapKit

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "10abd2dcd8626a4d75165599ff7c8625"
    var weatherID: Int?
    var weatherEmojis: String {
        get {
            switch weatherID! {
                // thunderstorm
            case 200: return "⛈"
            case 201: return "⛈⛈"
            case 202: return "⛈⛈⛈"
            case 210: return "🌩"
            case 211: return "🌩🌩"
            case 212: return "🌩🌩🌩"
            case 221: return "🌩  🌩"
            case 230: return "🌩☔️"
            case 231: return "🌩☔️☔️"
            case 232: return "🌩☔️☔️☔️"
                
                // drizzle
            case 300: return "☔️"
            case 301: return "☔️"
            case 302: return "💦☔️"
            case 310: return "☔️🌧"
            case 311: return "☔️🌧"
            case 312: return "💦☔️🌧"
            case 313: return "💦☔️🌧"
            case 314: return "💦☔️🌧"
            case 321: return "💦☔️"
                
                // rain
            case 500: return "🌧"
            case 501: return "🌧🌧"
            case 502: return "🌧🌧🌧"
            case 503: return "💦🌧🌧🌧"
            case 504: return "🌊"
            case 511: return "⛄️🌧"
            case 520: return "🌧"
            case 521: return "🌧🌧"
            case 522: return "🌧🌧🌧"
            case 531: return "🌧🌧"
                
                // snow
            case 600: return "🌨"
            case 601: return "🌨🌨"
            case 602: return "🌨🌨🌨"
            case 611: return "💦🌨"
            case 612: return "💦🌨🌨"
            case 615: return "🌧🌨"
            case 616: return "🌧🌨"
            case 620: return "☃️🌨"
            case 621: return "☃️🌨🌨☃️"
            case 622: return "☃️🌨🌨🌨☃️"
                
                // atmosphere
            case 701: return "🌫"
            case 711: return "💨"
            case 721: return "🌫"
            case 731: return "🌬"
            case 741: return "🌫"
            case 751: return "🏖"
            case 761: return "🌬"
            case 762: return "🌋"
            case 771: return "🌬"
            case 781: return "🌪"
                
                // clouds
            case 801: return "☁️"
            case 802: return "☁️☁️"
            case 803: return "☁️☁️"
            case 804: return "☁️💦☁️"
                
                // extreme
            case 900: return "🌪"
            case 901: return "🌊🌊"
            case 902: return "🌊🌊🌊"
            case 903: return "❄️"
            case 904: return "🔥"
            case 905: return "🌬"
            case 906: return "❄️🌧"
                
                // additional
            case 951: return "☀️"
            case 952: return "🌬"
            case 953: return "🌬"
            case 954: return "🌬"
            case 955: return "🌬"
            case 956: return "🌬💨"
            case 957: return "🌬💨💨"
            case 958: return "🌬💨💨"
            case 959: return "🌬💨💨💨"
            case 960: return "🌊"
            case 961: return "🌊🌊"
            case 962: return "🌊🌊🌊"
                
                // clear
            default: return "☀️"
            }
        }
    }
    
    func getWeatherID(coordinate: CLLocationCoordinate2D) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)")!
        
        // The data task retrieves the data.
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                // Case 1: Error
                print("Error:\n\(error)")
            }
            else {
                // Case 2: Success
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                    if let weather = json?["weather"] as? [[String:AnyObject]] {
                        if let id = weather.first?["id"] {
                            self.weatherID = id as? Int
                        }
                    }
                } catch {
                    print("Error:\n\(error)")
                }
            }
        }
        
        // The data task is set up...launch it!
        dataTask.resume()
    }
}
