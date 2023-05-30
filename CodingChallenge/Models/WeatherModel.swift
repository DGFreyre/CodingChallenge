//
//  WeatherModel.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName : String
    let temperature : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "Ok"
        default:
            return "Ok"
        }
    }
}
