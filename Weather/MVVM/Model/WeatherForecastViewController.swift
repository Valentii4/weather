//
//  WeatherForecastForNextFewDaysCollectionViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

private let reuseIdentifier = "weatherInDay"

class WeatherForecastViewController: UIViewController {
    var weatherForecastVM: WeatherForecastsViewModel?
    
    @IBOutlet weak var collectionsDays: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsDays.delegate = self
        collectionsDays.dataSource = self
    }
}

//MARK: - Collection View Delegate
extension WeatherForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecastVM?.numberOfItemsCatigories ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionsDays.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WeatherForecastCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.weatherViewModel = weatherForecastVM?.getWeatherViewModelWithIndexPath(row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        weatherForecastVM?.didSelectForecast(indexPath: indexPath.row)
    }
}
