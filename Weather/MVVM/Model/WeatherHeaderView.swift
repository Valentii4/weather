//
//  WeatherHeaderView.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

class WeatherHeaderViewController: UIViewController, Storyboarded {
    var weatherViewModel: WeatherViewModel?{
        didSet{
            weatherViewModel?.bindUpdateImage = {
                DispatchQueue.main.async {
                    self.picture.image = self.weatherViewModel?.image
                }
            }
            weatherViewModel?.bindUpdateInformationOnView = {
                DispatchQueue.main.async {
                    self.tempLabel.text = self.weatherViewModel?.temp
                    self.cityLabel.text = self.weatherViewModel?.cityName
                    self.weatherViewModel?.bindUpdateImage()
                }
            }
        }
    }
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        weatherViewModel?.bindUpdateInformationOnView()
    }
}
