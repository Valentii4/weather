//
//  AlamofireNetworkingManager.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
import Alamofire
import ObjectMapper
class AlamofireNetworkingManager {
    private let API_KEY: String = "e2d989bc-affa-474f-bfe5-43db338de5a4"
    private let LANGUAGE: String = "ru_RU"
    
    private func getUrlWeatherYandex(cityPoint: CityPoint) -> URL?{
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(cityPoint.latitude)&lon=\(cityPoint.longitude)&lang=\(LANGUAGE)"
        return URL(string: urlString)
    }
    
    private func printErrorDescription(error: AFError){
        print("\n\n===========Error===========")
        print("Error Code: \(error._code)")
        print("Error Messsage: \(error.localizedDescription)")
        debugPrint(error as Any)
        print("===========================\n\n")
    }
    
    private func getHttpHeadersWithApiKey() -> HTTPHeaders{
       return HTTPHeaders.init(["X-Yandex-API-Key" : API_KEY])
   }
}

extension AlamofireNetworkingManager: NetworkManager{
    func weatherInCity(cityPoint: CityPoint, completionhandler: @escaping  (_ data: WeatherItem?) -> Void){
        guard let url = getUrlWeatherYandex(cityPoint: cityPoint) else {
            return
        }
        let headers = getHttpHeadersWithApiKey()
        AF.request(url, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let jsonObject = value as? [String: Any] else { return }
                completionhandler(WeatherItem(json: jsonObject))
            
            case .failure(let error):
                self.printErrorDescription(error: error)
            }
        }
    }
}

