//
//  WeatherForecastForNextFewDaysCollectionViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

private let reuseIdentifier = "weatherInDay"

class WeatherForecastForNextFewDaysViewController: UIViewController {
    
    var vmWeatherForNextDays: ForecastsForNextDaysViewModel?
    
    @IBOutlet weak var collectionsDays: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsDays.delegate = self
        collectionsDays.dataSource = self
    }
}

//MARK: - Collection View Delegate
extension WeatherForecastForNextFewDaysViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vmWeatherForNextDays?.numberOfItemsCatigories ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionsDays.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WeatherForecastCollectionViewCell
        cell.weatherViewModel = vmWeatherForNextDays?.getWeatherViewModelWithIndexPath(row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vmWeatherForNextDays?.didSelectItemAt(indexPath: indexPath.row)
    }
}
