//
//  CityWeather.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    var name: String
}
// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}
// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
