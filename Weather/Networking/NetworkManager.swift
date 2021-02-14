//
//  NetworkManager.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
protocol NetworkManager{
    func weatherInCity(cityPoint: CityPoint, completionhandler: @escaping  (_ data: WeatherForecst?) -> Void)
}

