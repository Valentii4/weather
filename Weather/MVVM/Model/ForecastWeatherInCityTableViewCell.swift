//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import UIKit

class ForecastWeatherInCityTableViewCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?{
        didSet{
            weatherViewModel?.bindUpdateInformationOnView = {
                DispatchQueue.main.async {
                    self.updateView()
                }
            }
            weatherViewModel?.bindUpdateImage = {
                DispatchQueue.main.async {
                    self.updateImage()
                }
            }
            weatherViewModel?.bindUpdateInformationOnView()
        }
    }
    
    private func updateView(){
        cityLabel.text = weatherViewModel?.cityName
        conditionLabel.text = weatherViewModel?.condition
        tempLabel.text = weatherViewModel?.temp
        updateImage()
    }
    
    private func updateImage(){
        picture.image = weatherViewModel?.image
    }
    
}
