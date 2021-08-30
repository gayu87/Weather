//
//  WeatherViewControllerTests.swift
//  WeatherTests
//
//  Created by gayatri patel on 8/29/21.
//

import XCTest
@testable import Weather

class WeatherViewControllerTests: XCTestCase {
     var vC : WeatherViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vC?.getWeatherData(cityName: vC?.cityName ?? "")
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherConditionasconditionLabelText(){
        XCTAssertEqual(vC?.conditionLabel.text, vC?.weatherData?.weather[0].description)
    }
    func testCityNameAsCityLabelText(){
        XCTAssertEqual(vC?.cityLabel.text, vC?.weatherData?.name)
    }


}
