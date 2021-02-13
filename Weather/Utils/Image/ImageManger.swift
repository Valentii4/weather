//
//  ImageManger.swift
//  Weather
//
//  Created by Valentin Mironov on 11.02.2021.
//

import Foundation
import UIKit
protocol ImageManager{
    func getImageWithURL(url: URL) -> UIImage?
    func getImageWithImageName(name: String) -> UIImage?
}
