//
//  APIFetchable.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation
import Combine
import CoreLocation

/*struct WeatherFetcher {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "bd5275fa728650429bba49226acf134a"
    
    var delegate: WeatherDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&appid=\(appid)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherResponse.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
*/



struct WeatherFetcher {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "bd5275fa728650429bba49226acf134a"
    
    func fetchWeather(cityName: String) -> AnyPublisher<WeatherModel, Error> {
        let urlString = "\(weatherURL)?q=\(cityName)&appid=\(appid)"
        return performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<WeatherModel, Error> {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
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




