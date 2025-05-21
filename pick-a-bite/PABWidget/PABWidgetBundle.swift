//
//  PABWidgetBundle.swift
//  PABWidget
//
//  Created by Dimaseditiya on 09/05/25.
//

import WidgetKit
import SwiftUI

@main
struct PABWidgetBundle: WidgetBundle {
    var body: some Widget {
        PABWidget()
        PABWidgetControl()
        PABWidgetLiveActivity()
    }
}
