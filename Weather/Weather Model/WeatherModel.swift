//
//  WeatherModel.swift
//  Weather
//
//  Created by gayatri patel on 8/26/21.
//

import Foundation
import UIKit

enum APIError: String, Error {
    case badUrl = "Please search with different city name"
    case invalidData = "invalid city name"
    case invalidJosn = "not able to parse JSON"
}

class WeatherModel{
    func getData(for cityName: String, APIKey: String , completionHandler: @escaping (Result<WeatherData, APIError>) -> Void)  {
        
        let baseUrl =  "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey)&units=imperial"
        print(baseUrl)
        guard let url = URL(string: baseUrl) else {
            completionHandler(.failure(.badUrl))
            print("invalid Data")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.badUrl))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidData))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completionHandler(.success(weatherData))
            } catch {
                completionHandler(.failure(.invalidJosn))
            }
        }
        task.resume()
    }
  
}
