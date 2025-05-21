//
//  AppIntent.swift
//  PABWidget
//
//  Created by Dimaseditiya on 09/05/25.
//

import WidgetKit
import AppIntents
import SwiftUI

enum WidgetColorOption: String, AppEnum {
    case vividTangelo, green, blue

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Widget Color"
    }

    static var caseDisplayRepresentations: [Self: DisplayRepresentation] {
        [
            .vividTangelo: "Red",
            .green: "Green",
            .blue: "Blue"
        ]
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "cloud.sun.fill")
    var favoriteEmoji: String
   
    @Parameter(title: "Color Widget", default: "blue")
    var widgetColor: String
}

