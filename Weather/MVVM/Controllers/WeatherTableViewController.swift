//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Valentin Mironov on 12.02.2021.
//

import UIKit

private let tableViewIdentifier = "tableViewIdentifier"

class WeatherTableViewController: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var weatherViewModel: WeatherViewModel?
    var vmWeatherForNextDays: ForecastsForNextDaysViewModel?{
        didSet{
            vmWeatherForNextDays?.bindUpdateInformationOfWeather = {
                self.tableView.reloadData()
                if let vm = self.vmWeatherForNextDays?.weatherVM, let icon = vm.imageName{
                    self.weatherViewModel?.setInformationOfWeather(temp: vm.tempInt ?? 0, condition: vm.condition ?? "", iconName: icon)
                }
            }
            vmWeatherForNextDays?.bindUpdateInformationOnView()
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBSegueAction func createWeatherHeaderViewController(_ coder: NSCoder) -> WeatherHeaderViewController? {
        let vc = WeatherHeaderViewController(coder: coder)
        vc?.weatherViewModel = weatherViewModel
        return vc
    }
    
    @IBSegueAction func createForecastsForNextDays(_ coder: NSCoder) -> WeatherForecastForNextFewDaysViewController? {
        let vc = WeatherForecastForNextFewDaysViewController(coder: coder)
        let vmForecast = weatherViewModel?.getForecastsForNextDaysViewModel()
        vc?.vmWeatherForNextDays = vmForecast
        self.vmWeatherForNextDays = vmForecast
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmWeatherForNextDays?.numberOfRowsWeatherObject ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath)
        cell.textLabel?.text = vmWeatherForNextDays?.getTitleWetherObject(indexpath: indexPath.row)
        cell.detailTextLabel?.text = vmWeatherForNextDays?.getDetailWetherObject(indexpath: indexPath.row)

        return cell
    }
}
