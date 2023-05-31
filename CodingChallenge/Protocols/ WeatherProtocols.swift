//
//  FetchableProtocol.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherFetchingProtocol {
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherModel, Error>
   
}
protocol RequestPerformingProtocol {
    func performRequest(with urlString: String) -> AnyPublisher<WeatherModel, Error>
}

protocol JSONParsingProtocol {
    func parseJSON(_ weatherData: Data) -> AnyPublisher<WeatherModel, Error>
}

protocol WeatherLocalizationProtocol {
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<WeatherModel, Error>
}
