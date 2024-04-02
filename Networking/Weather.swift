import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Weather: Codable{
    let description: String
    let name: String
}

// MARK: - Main
struct Main:Codable{
    let temp: Double
    let humidity:Int
}



// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    
}

