//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import Foundation
import UIKit

class WeatherViewModel{
    @InjectImageManager private var imageManager: ImageManager
    private var weatherItem: WeatherForecst?
    private(set) var imageName: String?
    private(set) var tempInt: Int?
    private(set) var date: String?
    private(set) var image: UIImage?
    private(set) var temp: String?
    private(set) var condition: String?
    private(set) var isInfoFill: Bool = false
    let cityName: String
    
    var bindUpdateInformationOnView: (() -> ()) = {}
    var bindUpdateImage: (() -> ()) = {}
    
    init(cityName: String, imageName: String?, codition: String?, temp: Int?){
        self.cityName = cityName
        self.temp = ObjectConverter.tepmToString(temp: temp)
        self.imageName = imageName
        self.condition = codition
        self.tempInt = temp
        if let imageName = imageName{
            setImageWithName(name: imageName)
        }
        if imageName != nil, codition != nil, temp != nil{
            isInfoFill = true
        }
    }
    
    func setWeatherForecast(weatherForecast: WeatherForecst){
        self.weatherItem = weatherForecast
    }
    
    func setInformationOfWeather(temp: Int, condition: String, iconName: String){
        self.temp = ObjectConverter.tepmToString(temp: temp)
        self.condition = condition
        if imageName != iconName || image == nil{
            setImageWithName(name: iconName)
        }
        isInfoFill = true
        bindUpdateInformationOnView()
    }
    
    func setImageWithName(name: String){
        DispatchQueue.global().async {
            self.imageName = name
            self.image = self.imageManager.getImageWithImageName(name: name)
            self.bindUpdateImage()
        }
    }
    
    func setDate(date: Date){
        let formater = DateFormatter()
        formater.dateFormat = "d MMM"
        self.date = formater.string(from: date)
        bindUpdateInformationOnView()
    }
    
    func getWeatherForecast() -> WeatherForecastsViewModel?{
        guard let weather = weatherItem?.day else{ return nil }
        return WeatherForecastsViewModel(weatherForecast: weather, cityName: cityName)
    }
}
