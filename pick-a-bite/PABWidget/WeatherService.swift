import Foundation
import WeatherKit

class WeatherKitService: ObservableObject {
    private let service = WeatherService()
    
    // Published so that any changes to weather will notify SwiftUI views
    @Published var weather: Weather?
    
    func getWeather(lat: Double, long: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) { [weak self] in
                return try await self?.service.weather(for: .init(latitude: lat, longitude: long))
            }.value
        } catch {
            print("Failed to get weather data. \(error)")
        }
    }
    
    var icon: String {
        guard let iconName = weather?.currentWeather.symbolName else { return "--" }
        return iconName
    }
    
    var temperature: String {
        guard let temp = weather?.currentWeather.temperature else { return "--" }
        let convert = temp.converted(to: .celsius).value
        return String(Int(convert)) + "°C"
    }
    
    var temperatureAsInt: Int64 {
        guard let temp = weather?.currentWeather.temperature else { return 0 }
        let convert = temp.converted(to: .celsius).value
        return Int64(convert)
    }
    
    var humidityAsInt: Int64 {
        guard let humidity = weather?.currentWeather.humidity else { return 0 }
        let computedHumidity = humidity * 100
        return Int64(computedHumidity)
    }
    
    var humidity: String {
        guard let humidity = weather?.currentWeather.humidity else { return "--" }
        let computedHumidity = humidity * 100
        return String(Int(computedHumidity)) + "%"
    }
}
