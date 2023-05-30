//
//  FetchableProtocol.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager: WeatherFetcher, weather: WeatherModel)
    func didFailWithError(error: Error)
}
