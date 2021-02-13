//
//  objectConverter.swift
//  Weather
//
//  Created by Valentin Mironov on 13.02.2021.
//

import Foundation
class ObjectConverter {
    static func convertCloudness(cloudness: Double) -> String{
        switch cloudness {
        case 0:
            return "ясно"
        case 0.25:
            return "малооблачно"
        case 0.5:
            return "облачно с прояснениями"
        case 0.75:
            return "облачно с прояснениями"
        case 1:
            return "пасмурно"
        default:
            return ""
        }
    }
    
    static func converWindDir(windDir: String) -> String{
        switch windDir {
        case "nw":
            return "северо-западное"
        case "n":
            return "северное"
        case "ne":
            return "северо-восточное"
        case "e":
            return "восточное"
        case "se":
            return "юго-восточное"
        case "s":
            return "южное"
        case "sw":
            return "юго-западное"
        case "w":
            return "западное"
        case "c":
            return "штиль"
        default:
            return ""
        }
    }
    
    static func convertCondition(condition: String) -> String{
        switch condition {
        case "clear":
            return "ясно"
        case "partly-cloudy":
            return "малооблачно"
        case "cloudy":
            return "облачно с прояснениями"
        case "overcast":
            return "пасмурно"
        case "partly-cloudy-and-light-rain":
            return "небольшой дождь"
        case "partly-cloudy-and-rain":
            return "дождь"
        case "overcast-and-rain":
            return "сильный дождь"
        case "overcast-thunderstorms-with-rain":
            return "сильный дождь с грозой"
        case "cloudy-and-light-rain":
            return "облачно"
        case "overcast-and-light-rain":
            return "небольшой дождь"
        case "cloudy-and-rain":
            return "дождь"
        case "overcast-and-wet-snow":
            return "дождь со снегом"
        case "partly-cloudy-and-light-snow":
            return "небольшой снег"
        case "partly-cloudy-and-snow":
            return "малооблачно, снег"
        case "overcast-and-snow":
            return "снегопад"
        case "cloudy-and-light-snow":
            return "облачно, небольшой снег"
        case "overcast-and-light-snow":
            return "значительная облачность"
        case "cloudy-and-snow":
            return "облачно, снег"
        case "light-snow":
            return "небольшой снег"
        case "snow":
            return "снег"
        default:
            return ""
        }
    }
}
