//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

private let tableViewIdentifier = "tableViewIdentifier"

class WeatherTableViewController: UITableViewController, Storyboarded {
    var selectedWeatherVM: WeatherViewModel?
    var weatherForecastsVM: WeatherForecastsViewModel?{
        didSet{
            weatherForecastsVM?.bindUpdateInformationOfWeather = {
                self.tableView.reloadData()
                guard let vm = self.weatherForecastsVM else {
                    return
                }
                if let icon = vm.selectedImageName, let tempInt = vm.selectedTempInt, let codition = vm.selectedCondition {
                    self.selectedWeatherVM?.setInformationOfWeather(temp: tempInt, condition: codition, iconName: icon)
                }
            }
            weatherForecastsVM?.bindUpdateInformationOfWeather()
        }
    }
    
    //MARK: - Outlet/Action
    @IBOutlet var weatherForecastView: UIView!
    @IBSegueAction func createWeatherSomeInformationViewController(_ coder: NSCoder) -> WeatherSomeInformationViewController? {
        let vc = WeatherSomeInformationViewController(coder: coder)
        vc?.weatherViewModel = selectedWeatherVM
        return vc
    }
    
    @IBSegueAction func createWeaherForecastsCollectionView(_ coder: NSCoder) -> WeatherForecastViewController? {
        let vc = WeatherForecastViewController(coder: coder)
        let vmForecast = selectedWeatherVM?.getWeatherForecast()
        vc?.weatherForecastVM = vmForecast
        self.weatherForecastsVM = vmForecast
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedWeatherVM?.cityName
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecastsVM?.numberOfRowsWeatherObject ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath)
        cell.textLabel?.text = weatherForecastsVM?.getTitleWetherObject(indexpath: indexPath.row)
        cell.detailTextLabel?.text = weatherForecastsVM?.getDetailWetherObject(indexpath: indexPath.row)

        return cell
    }
}
