//
//  WeatherViewModel.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel?
    @Published var error: Error?
    private var cancellable = Set<AnyCancellable>()
    private let weatherFetcher: WeatherFetcher
    
    init(weatherFetcher: WeatherFetcher = WeatherFetcher()) {
        self.weatherFetcher = weatherFetcher
    }
    
    func fetchWeather(cityName: String) {
        weatherFetcher.fetchWeather(cityName: cityName)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Request successfully completed")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                DispatchQueue.main.async {
                    self?.weather = weather
                }
            }.store(in: &cancellable)

    }
}
