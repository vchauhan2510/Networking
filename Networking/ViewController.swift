//
//  ViewController.swift
//  Networking
//
//  Created by user239727 on 4/1/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var citylb: UILabel!
    
    @IBOutlet weak var weatherDescriptionlb: UILabel!
    
    @IBOutlet weak var weatherIconInageView: UIImageView!
    
    @IBOutlet weak var humiditylb: UILabel!
    
    
    @IBOutlet weak var temperatureData: UILabel!
    @IBOutlet weak var windspeedlb: UILabel!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    let apiKey = "http://api.openweathermap.org/geo/1.0/direct?q=Waterloo,Ca&appid=d4defae2405fb7e9fd7ce79e4bd83e40"
    
    //MARK: - Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    // MARK: - API Methods
       
       func fetchWeatherData() {
           guard let location = currentLocation else { return }
           let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=Waterloo,Ca&appid=d4defae2405fb7e9fd7ce79e4bd83e40"
           
           guard let url = URL(string: urlString) else { return }
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let error = error {
                   print("Error fetching weather data: \(error.localizedDescription)")
                   return
               }
               
               guard let data = data else { return }
               
               do {
                   let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                   DispatchQueue.main.async {
                       self.updateUI(with: weatherData)
                   }
               } catch let jsonError {
                   print("Error parsing JSON: \(jsonError.localizedDescription)")
               }
           }.resume()
       }
       
       // MARK: - UI Update Method
       
       func updateUI(with weatherData: Weather) {
           citylb.text = weatherData.name
           weatherDescriptionlb.text = weatherData.weather.first?.description ?? ""
           weatherIconInageView.image= "\(weatherData.WeatherElement.icon)
           temperatureData.text = "\(weatherData.main.temp) °C"
           humiditylb.text = "\(weatherData.main.humidity)%"
           windspeedlb.text = "\(weatherData.wind.speed) km/h"
       }
   }

   extension ViewController: CLLocationManagerDelegate {
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           currentLocation = location
           locationManager.stopUpdatingLocation()
           fetchWeatherData()
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Location manager failed with error: \(error.localizedDescription)")
       }
   }




