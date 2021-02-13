//
//  ViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import UIKit
import Toast_Swift
private let reuseIdentifier = "weatherCell"

final class ForecastsForCitiesViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var forecastsViewModel: ForecastsForCitiesViewModel?
    
    @IBOutlet weak var weatherSearchBar: UISearchBar!
    @IBOutlet weak var forecastsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastsTableView.delegate = self
        forecastsTableView.dataSource = self
        weatherSearchBar.delegate = self
    }
}
//MARK: - UITextFildDelegate
extension ForecastsForCitiesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let cityName = weatherSearchBar.text, let weatherViewModel = forecastsViewModel?.getWeatherViewModelWithCityName(cityName: cityName) else {
            return
        }
        if(weatherViewModel.temp == nil){
            self.forecastsTableView.makeToast("Погода в городе \(cityName), не найдена", duration: 2.0, position: .top)
            return
        }
        coordinator?.presentWeatherTableViewController(weatherViewModel: weatherViewModel)
        weatherSearchBar.text = ""
    }
}

//MARK: - TableViewDelegate
extension ForecastsForCitiesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return forecastsViewModel?.nubmerOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ForecastWeatherInCityTableViewCell
        let weatherViewModel = forecastsViewModel?.getWeatherViewModelWithIndexPath(row: indexPath.row)
        cell.weatherViewModel = weatherViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherViewModel = forecastsViewModel?.getWeatherViewModelWithIndexPath(row: indexPath.row) else{
            return
        }
        coordinator?.presentWeatherTableViewController(weatherViewModel: weatherViewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

