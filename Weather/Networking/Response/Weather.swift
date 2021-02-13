//
//  Weather.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
struct Weather: Response {
    let tempAvg: Int
    let tempMax: Int
    let tempMin: Int
    let condition: String
    let icon: String
    let windSpeed: Double
    let windDir: String
    let pressure: Int
    let cloudness: Double
    var date: Date?
    
    init(json: [String: Any]) {
        tempAvg = json["temp_avg"] as! Int
        tempMax = json["temp_max"] as! Int
        tempMin = json["temp_min"] as! Int
        condition = json["condition"] as! String
        icon = json["icon"] as! String
        windSpeed = json["wind_speed"] as! Double
        windDir = json["wind_dir"] as! String
        pressure = json["pressure_mm"] as! Int
        cloudness = json["cloudness"] as! Double
    }
}
