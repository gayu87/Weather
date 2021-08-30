//
//  WeatherData.swift
//  Weather
//
//  Created by gayatri patel on 8/26/21.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    
}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let main, description, icon: String
    
}

