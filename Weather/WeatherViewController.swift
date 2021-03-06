//
//  ViewController.swift
//  Weather
//
//  Created by gayatri patel on 8/26/21.
//

import UIKit
import MapKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var currantLocationArrow: UIButton!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    var weatherData : WeatherData?
    var model =  WeatherModel()
    var locationManager = CLLocationManager()
    var degree = "\u{00B0}"
    var cityName = ""
    var currentCityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setbackgroundImage()
        cityNameTextField.setBorder(textField: cityNameTextField)
        currantLocationArrow.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setbackgroundImage(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Clear.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        getCurretLocationCity(from: location) { city, error in
            guard let city = city, error == nil else { return }
            print(city)
            self.currentCityName = city
            self.getWeatherData(cityName: self.currentCityName)
        }
    }
    
    func getCurretLocationCity(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       error)
        }
    }
    
    @IBAction func searchButtonClick(_ sender: Any) {
        cityName = cityNameTextField.text ?? ""
        if cityName.count == 0 {
            currentLocationLabel.isHidden = false
            showAlert(title: "Alert", message: "Please enter city name")}
        else{
            currentLocationLabel.isHidden = true
            currantLocationArrow.setImage(UIImage(systemName: "location"), for: .normal)
            getWeatherData(cityName: cityName)}
    }
    
    @IBAction func currentLocationClicked(_ sender: Any) {
        currentLocationLabel.isHidden = false
        currantLocationArrow.setImage(UIImage(systemName: "location.fill"), for: .normal)
        getWeatherData(cityName: currentCityName)
    }
    
    func getWeatherData(cityName: String){
        var CityNameWithNoSpace = cityName
        if cityName.contains(" "){
            CityNameWithNoSpace = cityName.replacingOccurrences(of: " ", with: "%20")
        }
        model.getData(for:  CityNameWithNoSpace, APIKey: "9edc1a6ad6bd0fc5b25b7ff6bfa6684f", completionHandler: { [weak self] info in
            switch info {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.weatherData = weather
                    print(weather)
                    self?.cityLabel.text = self?.weatherData?.name
                    self?.conditionLabel.text = self?.weatherData?.weather[0].description
                    
                    self?.weatherLabel.text = "\(String(self?.weatherData?.main.temp ?? 0 ))\u{00B0}F"
                    self?.minMaxLabel.text = "H: \(String(self?.weatherData?.main.tempMax ?? 0))\u{00B0}   L: \(String(self?.weatherData?.main.tempMin ?? 0))\u{00B0}"
                    if self?.weatherData == nil{
                        self?.showAlert(title: "Alert", message: "No data found")
                    }else{
                        self?.stackView.reloadInputViews()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Alert", message: error.rawValue)
                }
            }
        } )
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
