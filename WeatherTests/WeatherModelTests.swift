//
//  WeatherModelTests.swift
//  WeatherTests
//
//  Created by gayatri patel on 8/29/21.
//

import XCTest
@testable import Weather

class WeatherModelTests: XCTestCase {
    var weatherData : WeatherData?
    
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
            let decoder = JSONDecoder()
            let bundel = Bundle(for: type(of: self))
            if let url = bundel.url(forResource: "Weather", withExtension: "json"){
                do{
                    let json = try Data(contentsOf: url)
                    let data = try decoder.decode(WeatherData.self, from: json)
                    weatherData = data
                    print(weatherData)
                    
                } catch{
                    print("Unable to process json")
                }
            }
        
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherData = nil
    }

    func testDataIsnotNil(){
        XCTAssertNotNil(weatherData)
    }
    func testCityName(){
        XCTAssertEqual("Detroit", weatherData?.name)
    }
    func testTemperature(){
        XCTAssertEqual(72.57, weatherData?.main.temp)
    }

}
