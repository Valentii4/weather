//
//  ForecastsForNextDaysViewModel.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import Foundation
class WeatherForecastsViewModel {
    private var weatherForecast: [Weather]
    private var selectedWeather: Weather?
    private let cityName: String
    
    var selectedImageName: String?{
        return selectedWeather?.icon
    }
    var selectedTempInt: Int?{
        return selectedWeather?.tempAvg
    }
    var selectedCondition: String?{
        return selectedWeather?.condition
    }
    var numberOfItemsCatigories: Int{
        return weatherForecast.count
    }
    var numberOfRowsWeatherObject: Int{
        return WeatherObject.allCases.count
    }
    var bindUpdateInformationOfWeather: (() -> ()) = {}
    
    init(weatherForecast: [Weather], cityName: String) {
        self.weatherForecast = weatherForecast
        self.cityName = cityName
        if let weather = weatherForecast.first{
            selectedWeather = weather
        }
    }
    
    func getWeatherViewModelWithIndexPath(row: Int) -> WeatherViewModel {
        let day = weatherForecast[row]
        let vm = WeatherViewModel(cityName: cityName, imageName: day.icon, codition: day.condition, temp: day.tempAvg)
        if let date = day.date{
            vm.setDate(date: date)
        }
        return vm
    }
    
    func didSelectForecast(indexPath row: Int){
        selectedWeather = weatherForecast[row]
        bindUpdateInformationOfWeather()
    }
    
    //MARK: - Table view func
    func getTitleWetherObject(indexpath row: Int) -> String {
        return getWeatherObject(indexPath: row).rawValue
    }
    
    func getDetailWetherObject(indexpath row: Int) -> String {
        let weatherInformation = getWeatherObject(indexPath: row)
        guard  let weather = selectedWeather else {
            return ""
        }
        switch weatherInformation {
        case .tampMin:
            return ObjectConverter.tepmToString(temp:weather.tempMin) ?? ""
        case .tempAvg:
            return ObjectConverter.tepmToString(temp:weather.tempAvg) ?? ""
        case .tempMax:
            return ObjectConverter.tepmToString(temp:weather.tempMax) ?? ""
        case.windSpeed:
            return String(weather.windSpeed)
        case .windDir:
            return weather.windDir
        case .condition:
            return weather.condition
        case .pressure:
            return String(weather.pressure)
        }
    }
    
    private func getWeatherObject(indexPath row: Int) -> WeatherObject{
        return WeatherObject.allCases[row]
    }
    
    private enum WeatherObject: String, CaseIterable{
        case tempAvg = "Температура воздуха"
        case tempMax = "Максимальная температура"
        case tampMin = "Минимальная температура"
        case windDir = "Направление ветра"
        case windSpeed = "Скорость ветра  (в м/с)"
        case pressure = "Давление (в мм рт. ст.)"
        case condition = "Ожидается"
    }
}
