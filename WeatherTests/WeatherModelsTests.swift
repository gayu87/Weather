//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by gayatri patel on 8/26/21.
//

import XCTest
@testable import Weather

class WeatherModelsTests: XCTestCase {

    var model:  WeatherModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model?.getMockData()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
    }
    
func testCityName(){
    XCTAssertNotNil(model?.weatherData)
        
    }


}
