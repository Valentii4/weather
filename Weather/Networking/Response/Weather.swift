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
    var condition: String
    let icon: String
    let windSpeed: Double
    var windDir: String
    let pressure: Int
    var cloudness: String
    var date: Date?
    
    init(json: [String: Any]) {
        tempAvg = json["temp_avg"] as! Int
        tempMax = json["temp_max"] as! Int
        tempMin = json["temp_min"] as! Int
        icon = json["icon"] as! String
        windSpeed = json["wind_speed"] as! Double
        pressure = json["pressure_mm"] as! Int
        cloudness = ObjectConverter.convertCloudness(cloudness: json["cloudness"] as! Double)
        windDir = ObjectConverter.converWindDir(windDir: json["wind_dir"] as! String)
        condition = ObjectConverter.convertCondition(condition: json["condition"] as! String)
    }
    
    
}
