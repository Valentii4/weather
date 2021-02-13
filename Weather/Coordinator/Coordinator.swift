//
//  Coordinator.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
