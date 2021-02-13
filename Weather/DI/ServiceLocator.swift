//
//  ServiceLocator.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import Foundation
import Swinject

final class ServiceLocator {
    private static let container = Container()
    
    public static func register<T>(name: Id, value: T) {
        container.register(type(of: value), name: name.rawValue) { _ in value }
    }
    
    public static func resolve<T>(service: T.Type, name: Id) -> T? {
        return container.resolve(service, name: name.rawValue)
    }
    
    enum Id: String {
        case networkManager = "networkManager"
        case nsCache = "nsCache"
        case imageManager = "imageManager"
    }
}

