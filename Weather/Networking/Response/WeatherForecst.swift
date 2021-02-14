//
//  WeatherItem.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
struct WeatherForecst: Response{
    var day: [Weather] = []
    var night: [Weather] = []
    let city: String
    let temp: Int
    let iconName: String
    let condition: String
    
    init?(json: [String : Any]) {
        guard let fact = json["fact"] as? [String:Any],
              let temp = fact["temp"] as? Int,
              let iconName = fact["icon"] as? String,
              let condition = fact["condition"] as? String,
              let geoObject = json["geo_object"] as? [String:Any],
              let province = geoObject["province"] as? [String:Any],
              let city = province["name"] as? String,
              let forecasts =  json["forecasts"] as? [[String: Any]]
        else {
            return nil
        }
        
        self.temp = temp
        self.iconName = iconName
        self.city = city
        self.condition = ObjectConverter.convertCondition(condition: condition)
        day = getWeathers(timeDay: .day, forecasts: forecasts)
        night = getWeathers(timeDay: .night, forecasts: forecasts)
    }
    
    
    private func getWeathers(timeDay: TimeDay, forecasts: [[String:Any]]) -> [Weather]{
        var result: [Weather] = []
        for forecast in forecasts{
            let date = getDateFromForecast(forecast: forecast)
            let parts = forecast["parts"] as! [String:Any]
            let weatherJson = parts[timeDay.rawValue] as! [String:Any]
            if var weatherObject = Weather(json: weatherJson){
                weatherObject.date = date
                result.append(weatherObject)
            }
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
