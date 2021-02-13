//
//  Response.swift
//  Weather
//
//  Created by Valentin Mironov on 10.02.2021.
//

import Foundation
protocol Response {
    init(json: [String:Any])
}
