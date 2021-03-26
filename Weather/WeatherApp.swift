//
//  WeatherApp.swift
//  Weather
//
//  Created by Adam Young on 24/02/2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    @StateObject private var model = WeatherModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherPageView()
                .environmentObject(model)
        }
    }
}
