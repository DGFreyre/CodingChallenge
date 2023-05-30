//
//  WeatherError.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import Foundation

enum WeatherError : Error {
    case jsonParsingFailed
    case networkError
    case invalidURL
}
