//
//  APIFetchable.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation
import Combine
import CoreLocation


struct WeatherFetcher : WeatherFetchingProtocol, RequestPerformingProtocol, JSONParsingProtocol{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "bd5275fa728650429bba49226acf134a"
    
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherModel, Error> {
        let urlString = "\(weatherURL)?q=\(cityName)&appid=\(appid)"
        return performRequest(with: urlString)
    }
    func performRequest(with urlString: String) -> AnyPublisher<WeatherModel, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: WeatherError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let session = URLSession.shared
        return session.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .flatMap { data, _ in
                self.parseJSON(data)
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func parseJSON(_ weatherData: Data) -> AnyPublisher<WeatherModel, Error> {
        let decoder = JSONDecoder()
        return Just(weatherData)
            .decode(type: WeatherResponse.self, decoder: decoder)
            .map { decodedData in
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                return weather
            }
            .mapError { error -> Error in
                return WeatherError.jsonParsingFailed
            }
            .eraseToAnyPublisher()
    }
}




