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
    private let TEMP_CALCULUS_SYSTEM = " °C"
    private var weatherItem: WeatherItem?
    private(set) var imageName: String?
    private(set) var tempInt: Int?
    private(set) var date: String?
    private(set) var image: UIImage?
    private(set) var temp: String?
    private(set) var condition: String?
    let cityName: String
    
    var bindUpdateInformationOnView: (() -> ()) = {}
    var bindUpdateImage: (() -> ()) = {}
    
    init(cityName: String, imageName: String?, codition: String?, temp: Int?){
        self.cityName = cityName
        self.temp = tepmToString(temp: temp)
        self.imageName = imageName
        self.tempInt = temp
        if let imageName = imageName{
            setImageWithName(name: imageName)
        }
    }
    

    func setWeatherItem(weatherItem: WeatherItem){
        self.weatherItem = weatherItem
    }
    
    func setInformationOfWeather(temp: Int, condition: String, iconName: String){
        self.temp = tepmToString(temp: temp)
        self.condition = condition
        if imageName != iconName || image == nil{
            setImageWithName(name: iconName)
        }
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
    
    func getForecastsForNextDaysViewModel() -> ForecastsForNextDaysViewModel?{
        guard let weather = weatherItem?.day else{ return nil }
        return ForecastsForNextDaysViewModel(weatherForNextDays: weather, cityName: cityName)
    }
    
    func tepmToString(temp: Int?) -> String?{
        guard let tempInt = temp else{ return nil }
        return String(tempInt) + TEMP_CALCULUS_SYSTEM
    }
    
}
