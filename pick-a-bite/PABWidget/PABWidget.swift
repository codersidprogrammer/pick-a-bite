//
//  PABWidget.swift
//  PABWidget
//
//  Created by Dimaseditiya on 09/05/25.
//

import WidgetKit
import SwiftUI
import CoreLocation

struct Provider: AppIntentTimelineProvider {
    
    private var weatherService = WeatherKitService()
    private var predictService = WidgetPredictService()
    private var tenantPredictService = MainPredictService()
    
    let jakarta = CLLocation(latitude: -6.21462, longitude: 106.84513)
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), widgetColor: "VividTangelo", tenantName: "FORE Coffee")
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, widgetColor: "VividTangelo", tenantName: "FORE Coffee")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        await weatherService.getWeather(lat: jakarta.coordinate.latitude, long: jakarta.coordinate.longitude)
        
        // Create entries for the next 60 minutes
        for minuteOffset in 0..<60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            var _widgetColor = "VividTangelo"
            var _configuration: ConfigurationAppIntent = .brightsun
            var _message = "Need something good today?"
            
            if weatherService.temperatureAsInt < 25 {
                _widgetColor = "BlueRain"
                _configuration = .rainy
                _message = "Need more warm today"
            } else if weatherService.temperatureAsInt >= 25 && weatherService.temperatureAsInt < 30 {
                _widgetColor = "BlueNormal"
                _configuration = .cloudy
                _message = "Need more calmness?"
            } else {
                _widgetColor = "VividTangelo"
                _configuration = .brightsun
                _message = "I have something good for you!"
            }
            
            let _result = _predict(weatherService.temperatureAsInt, weatherService.humidityAsInt)
            
            let tenantName = _result.first?.key ?? "DefaultTenantName"  // Use a default if the result is empty
                
            // Add the weather data to each entry
            let entry = SimpleEntry(
                date: entryDate,
                configuration: _configuration,
                widgetColor: _widgetColor,
                tenantName: tenantName,
                message: _message
            )
            entries.append(entry)
        }

        
        // Create and return the timeline, set to refresh after 60 seconds
        return Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(60 * 60)))
    }
    
    
    func _predict(_ temp: Int64, _ humid: Int64) -> [String: Any] {

        // Make a prediction using your service
        let predictToken = predictService.predict(preferences: FeatureDto(temp: temp, humid: humid))
            .sorted(by: { $0.value > $1.value })


        guard let token = predictToken.first else {
            return [:] // Return an empty dictionary if no predictions are available
        }

        // Split the string by "|"
        let categoriesArray = token.key.split(separator: "|").map { String($0) } // Get categories from token's key
//        print(categoriesArray)

        // Create the dictionary with each category set to 1
        let jsonDict: [String: Any] = Dictionary(uniqueKeysWithValues: categoriesArray.map { ($0, 1) })

        // Now you can pass the dictionary into the PreferenceDto
        guard PreferenceDto.fromJson(jsonDict) != nil else {
            print("Failed to parse JSON")
            return [:]
        }

        // Predict using the preferences
        let predicts = tenantPredictService.predict(
            preferences: PreferenceDto.fromJson(jsonDict) ?? PreferenceDto()
        )
            .sorted(by: { $0.value > $1.value })

        // Return the first prediction as a dictionary (key-value pair)
        guard let firstPrediction = predicts.first else {
            return [:] // Return an empty dictionary if no predictions available
        }

        return [firstPrediction.key: firstPrediction.value]
    }

    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    var widgetColor: String
    var tenantName: String
    var message: String
}

extension SimpleEntry {
    
    init() {
        self.date = Date()
        self.message = "This is default message"
        self.tenantName = "Default tenant"
        self.widgetColor = "VividTangelo"
        self.configuration = .brightsun
    }
    
    init(date: Date, configuration: ConfigurationAppIntent, widgetColor: String, tenantName: String) {
        self.date = Date()
        self.message = "Need something good today?"
        self.tenantName = tenantName
        self.widgetColor = widgetColor
        self.configuration = configuration
    }
}

struct PABWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: entry.configuration.favoriteEmoji)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 100)
                    .foregroundColor(.white)
                    .opacity(0.4)
                    .offset(x: 62, y: -75)
                
                
                VStack(alignment:.leading) {
                    Text(entry.message)
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.papayaWhip)
                        .lineSpacing(.zero)
                        .frame(width: 96, alignment: .leading)
                        .padding(.bottom, 16)
                    
                    Text("Let's try")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.papayaWhip)
                    Text(entry.tenantName)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .lineSpacing(.zero)
                        .foregroundColor(.white)
                    
                }
                
                Spacer()
                
            }
        }
        .padding(.horizontal, 2)
        .widgetURL(URL(string: "pickabite://roulettePage"))
    }
}

struct PABWidget: Widget {
    let kind: String = "com.pabteam.pickabite.widget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PABWidgetEntryView(entry: entry)
                .containerBackground(Color(entry.widgetColor), for: .widget)
        }
        .description("Pick A Bite")
        .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var brightsun: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "sun.max.fill"
        return intent
    }
    
    fileprivate static var cloudy: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "cloud.sun.fill"
        return intent
    }
    
    fileprivate static var rainy: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "cloud.heavyrain.fill"
        return intent
    }
}

#Preview(as: .systemSmall) {
    PABWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .brightsun, widgetColor: "VividTangelo", tenantName: "Dum Dum Cha")
    SimpleEntry(date: .now, configuration: .cloudy, widgetColor: "BlueNormal", tenantName: "FORE Coffee")
    SimpleEntry(date: .now, configuration: .rainy, widgetColor: "BlueRain", tenantName: "FORE Coffee")
}
