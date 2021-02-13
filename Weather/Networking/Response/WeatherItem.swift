//
//  WeatherItem.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
struct WeatherItem: Response{
    var day: [Weather] = []
    var night: [Weather] = []
    let city: String
    let temp: Int
    let iconName: String
    let condition: String
    
    init(json: [String : Any]) {
        let fact = json["fact"] as! [String:Any]
        temp = fact["temp"] as! Int
        iconName = fact["icon"] as! String
        condition = fact["condition"] as! String
        
        let geoObject = json["geo_object"] as! [String:Any]
        let province = geoObject["province"] as! [String:Any]
        city = province["name"] as! String
        
        let forecasts =  json["forecasts"] as! [[String: Any]]
        day = getWeathers(timeDay: .day, forecasts: forecasts)
        night = getWeathers(timeDay: .night, forecasts: forecasts)
        
    }
    
    
    private func getWeathers(timeDay: TimeDay, forecasts: [[String:Any]]) -> [Weather]{
        var result: [Weather] = []
        for forecast in forecasts{
            let date = getDateFromForecast(forecast: forecast)
            let parts = forecast["parts"] as! [String:Any]
            let weatherJson = parts[timeDay.rawValue] as! [String:Any]
            var weatherObject = Weather(json: weatherJson)
            weatherObject.date = date
            result.append(weatherObject)
        }
        return result
    }
    
    private func getDateFromForecast(forecast: [String:Any]) -> Date?{
        let stringDate = forecast["date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate)
    }
    
    private enum TimeDay: String {
        case night = "night"
        case day = "day"
    }
}
