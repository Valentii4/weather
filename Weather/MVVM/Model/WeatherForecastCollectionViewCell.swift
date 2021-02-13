//
//  WeatherForecastCollectionViewCell.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {
    
    var weatherViewModel: WeatherViewModel?{
        didSet{
            weatherViewModel?.bindUpdateImage = {
                DispatchQueue.main.async {
                    self.updateImage()
                }
            }
            weatherViewModel?.bindUpdateInformationOnView = {
                DispatchQueue.main.async {
                    self.updateView()
                }
            }
            weatherViewModel?.bindUpdateInformationOnView()
        }
    }
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private func updateView(){
        dateLabel.text = weatherViewModel?.date
        tempLabel.text = weatherViewModel?.temp
        updateImage()
    }
    
    private func updateImage(){
        picture.image = weatherViewModel?.image
    }

}
