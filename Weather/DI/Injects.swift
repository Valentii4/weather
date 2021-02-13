//
//  Injects.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//


//думаю все эти классы можно было бы как-нибудь объеденить через дженерик или хотябы подписать под один протокол, в будущем передлаю
import Foundation
@propertyWrapper
class InjectCache<NSCache> {
    private var kept: NSCache?
    
    public var wrappedValue: NSCache {
        //не знаю как сделать лучше кроме как неявного развертывания и если не сохранить в appdelegate то будет краш в рантайме, если знаете подскажите буду благодарен
        kept ?? {
            let dependency: NSCache = ServiceLocator.resolve(service: NSCache.self, name: .nsCache)!
            kept = dependency
            return dependency
        }()
    }
}

@propertyWrapper
class InjectNetworkManager <NetworkManager> {
    private var kept: NetworkManager?
    
    public var wrappedValue: NetworkManager {
        //не знаю как сделать лучше кроме как неявного развертывания и если не сохранить в appdelegate то будет краш в рантайме, если знаете подскажите буду благодарен
        kept ?? {
            let dependency: NetworkManager = ServiceLocator.resolve(service: NetworkManager.self, name: .networkManager)!
            kept = dependency
            return dependency
        }()
    }
}

@propertyWrapper
class InjectImageManager <ImageManager> {
    private var kept: ImageManager?
    
    public var wrappedValue: ImageManager {
        //не знаю как сделать лучше кроме как неявного развертывания и если не сохранить в appdelegate то будет краш в рантайме, если знаете подскажите буду благодарен
        kept ?? {
            let dependency: ImageManager = ServiceLocator.resolve(service: ImageManager.self, name: .imageManager)!
            kept = dependency
            return dependency
        }()
    }
}
