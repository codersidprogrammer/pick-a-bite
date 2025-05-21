//
//  PABWidgetLiveActivity.swift
//  PABWidget
//
//  Created by Dimaseditiya on 09/05/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PABWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PABWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PABWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PABWidgetAttributes {
    fileprivate static var preview: PABWidgetAttributes {
        PABWidgetAttributes(name: "World")
    }
}

extension PABWidgetAttributes.ContentState {
    fileprivate static var smiley: PABWidgetAttributes.ContentState {
        PABWidgetAttributes.ContentState(emoji: "there")
     }
     
     fileprivate static var starEyes: PABWidgetAttributes.ContentState {
         PABWidgetAttributes.ContentState(emoji: "there")
     }
}

#Preview("Notification", as: .content, using: PABWidgetAttributes.preview) {
   PABWidgetLiveActivity()
} contentStates: {
    PABWidgetAttributes.ContentState.smiley
    PABWidgetAttributes.ContentState.starEyes
}
