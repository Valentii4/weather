//
//  MainCoordinator.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ForecastsForCitiesViewController.instantiate()
        vc.forecastsViewModel = ForecastsForCitiesViewModel()
        vc.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator{
    func presentWeatherTableViewController(weatherViewModel: WeatherViewModel){
        let vc = WeatherTableViewController.instantiate()
        vc.weatherViewModel = weatherViewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
