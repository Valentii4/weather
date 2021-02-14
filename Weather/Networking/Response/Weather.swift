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
    let cloudness: String
    var date: Date?
    
    init?(json: [String: Any]) {
        guard
        let tempAvg = json["temp_avg"] as? Int,
        let tempMax = json["temp_max"] as? Int,
        let tempMin = json["temp_min"] as? Int,
        let icon = json["icon"] as? String,
        let windSpeed = json["wind_speed"] as? Double,
        let pressure = json["pressure_mm"] as? Int,
        let cloudness =  json["cloudness"] as? Double,
        let windDir = json["wind_dir"] as? String,
        let condition = json["condition"] as? String else{
            return nil
        }
        
        self.cloudness =  ObjectConverter.convertCloudness(cloudness: cloudness)
        self.windDir = ObjectConverter.converWindDir(windDir: windDir)
        self.condition =  ObjectConverter.convertCondition(condition: condition)
        self.tempAvg = tempAvg
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.icon = icon
        self.windSpeed = windSpeed
        self.pressure = pressure
    }
}
