//
//  ForecastsForNextDaysViewModel.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import Foundation
class ForecastsForNextDaysViewModel: WeatherViewModel {
    private var weatherForNextDays: [Weather]
    private var selectedWeather: Weather?
    private(set) var weatherVM: WeatherViewModel?
    
    var bindUpdateInformationOfWeather: (() -> ()) = {}
    
    var numberOfItemsCatigories: Int{
        return weatherForNextDays.count
    }
    
    var numberOfRowsWeatherObject: Int{
        return WeatherInformation.allCases.count
    }
    
    init(weatherForNextDays: [Weather], cityName: String) {
        self.weatherForNextDays = weatherForNextDays
        super.init(cityName: cityName, imageName: nil, codition: nil, temp: nil)
        if let weather = weatherForNextDays.first{
            selectedWeather = weather
        }
    }
    
    func getWeatherViewModelWithIndexPath(row: Int) -> WeatherViewModel {
        let day = weatherForNextDays[row]
        let vm = WeatherViewModel(cityName: cityName, imageName: day.icon, codition: day.condition, temp: day.tempAvg)
        if let date = day.date{
            vm.setDate(date: date)
        }
        return vm
    }
    
    func didSelectItemAt(indexPath row: Int){
        let vm = getWeatherViewModelWithIndexPath(row: row)
        self.weatherVM = vm
        selectedWeather = weatherForNextDays[row]
        bindUpdateInformationOfWeather()
    }
    
    func getTitleWetherObject(indexpath row: Int) -> String {
        return getWeatherInformation(indexPath: row).rawValue
    }
    
    func getDetailWetherObject(indexpath row: Int) -> String {
        let weatherInformation = getWeatherInformation(indexPath: row)
        guard  let weather = selectedWeather else {
            return ""
        }
        switch weatherInformation {
        case .tampMin:
            return self.tepmToString(temp:weather.tempMin) ?? ""
        case .tempAvg:
            return self.tepmToString(temp:weather.tempAvg) ?? ""
        case .tempMax:
            return self.tepmToString(temp:weather.tempMax) ?? ""
        case.windSpeed:
            return String(weather.windSpeed)
        case .windDir:
            return weather.windDir ?? ""
        case .condition:
            return weather.condition ?? ""
        case .pressure:
            return String(weather.pressure)
        }
        
    }
    
    private func getWeatherInformation(indexPath row: Int) -> WeatherInformation{
        return WeatherInformation.allCases[row]
    }
    
    private enum WeatherInformation: String, CaseIterable{
        case tempAvg = "Температура воздуха"
        case tempMax = "Максимальная температура"
        case tampMin = "Минимальная температура"
        case windDir = "Направление ветра"
        case windSpeed = "Скорость ветра  (в м/с)"
        case pressure = "Давление (в мм рт. ст.)"
        case condition = "Ожидается"
    }
}
