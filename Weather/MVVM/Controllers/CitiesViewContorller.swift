//
//  ViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import UIKit
import Toast_Swift
private let reuseIdentifier = "weatherCell"

final class CitiesViewContorller: UIViewController, Storyboarded {
    
    private var citiesViewModel: CitiesViewModel = CitiesViewModel()
    
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
extension CitiesViewContorller: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let cityName = weatherSearchBar.text else {
            return
        }
        let weatherViewModel = citiesViewModel.getWeatherViewModelWithCityName(cityName: cityName)
        if(weatherViewModel.temp == nil){
            self.forecastsTableView.makeToast("Погода в городе \(cityName), не найдена", duration: 2.0, position: .top)
            return
        }
        pushWeatherTableVC(selectedWeatherVM: weatherViewModel)
    }
}

//MARK: - TableViewDelegate
extension CitiesViewContorller: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return citiesViewModel.nubmerOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CityTableViewCell else{
            return UITableViewCell()
        }
        let weatherViewModel = citiesViewModel.getWeatherViewModelWithIndexPath(row: indexPath.row)
        cell.weatherViewModel = weatherViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWeatherVM = citiesViewModel.getWeatherViewModelWithIndexPath(row: indexPath.row)
        pushWeatherTableVC(selectedWeatherVM: selectedWeatherVM)
    }
}

//MARK: - Navigation
extension CitiesViewContorller{
    private func pushWeatherTableVC(selectedWeatherVM: WeatherViewModel){
        let vc = WeatherTableViewController.instantiate()
        vc.selectedWeatherVM = selectedWeatherVM
        if(selectedWeatherVM.isInfoFill){
            self.navigationController?.pushViewController(vc, animated: true)
        }
        weatherSearchBar.text = ""
    }
}
