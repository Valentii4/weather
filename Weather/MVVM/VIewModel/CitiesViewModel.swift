//
//  ForecastsVIewModel.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
class CitiesViewModel {
    @InjectNetworkManager private var networking: NetworkManager
    @InjectCache private var cache: NSCache<NSString, WeatherViewModel>
    private lazy var arrayCitysKey = citys.keys.sorted()
    private let citys: [String:CityPoint] = ["Москва": CityPoint(latitude: 55.7504461, longitude: 37.6174943),
                                "Санкт-Петербург":CityPoint(latitude: 59.9606739, longitude: 30.1586551),
                                "Уфа":CityPoint(latitude: 54.7261409, longitude: 55.947499),
                                "Саратов":CityPoint(latitude: 51.530018, longitude: 46.034683),
                                "Сочи":CityPoint(latitude: 43.5854823, longitude: 39.723109),
                                "Оренбург":CityPoint(latitude: 51.767452, longitude: 55.097118),
                                "Ярославль":CityPoint(latitude: 57.6263877, longitude: 39.8933705),
                                "Казань":CityPoint(latitude: 55.7823547, longitude: 49.1242266),
                                "Тюмень":CityPoint(latitude: 57.153534, longitude: 65.542274),
                                "Пермь":CityPoint(latitude: 58.014965, longitude: 56.246723)]
    
    var nubmerOfRows: Int {
        return citys.count
    }

    func getWeatherViewModelWithIndexPath(row: Int) -> WeatherViewModel{
        let cityName = arrayCitysKey[row]
        return getWeatherViewModelWithCityName(cityName: cityName)
    }
    
    func getWeatherViewModelWithCityName(cityName: String) -> WeatherViewModel{
        if let vm = cache.object(forKey: cityName as NSString){
            return vm
        }
        let vmWeather = WeatherViewModel(cityName: cityName, imageName: nil, codition: nil,temp: nil)
        guard let cityPoint = citys[cityName] else{
            return vmWeather
        }
        networking.weatherInCity(cityPoint: cityPoint) { [cityName] (item) in
            guard let weatherItem = item else{ return }
            vmWeather.setWeatherForecast(weatherForecast: weatherItem)
            vmWeather.setInformationOfWeather(temp: weatherItem.temp, condition: weatherItem.condition, iconName: weatherItem.iconName)
            self.cache.setObject(vmWeather, forKey: cityName as NSString)
        }
        return vmWeather
    }
}
    
