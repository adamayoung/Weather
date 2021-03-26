//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Adam Young on 24/02/2021.
//

import WeatherCore
import SwiftUI

struct WeatherDetailView: View {
    
    var place: Place
    var weather: Weather?
    
    private var condition: Condition? {
        weather?.conditions.first
    }
    
    private var temperature: Measurement<UnitTemperature>? {
        weather?.temperature
    }

    var body: some View {
        VStack {
            Spacer()
            Text("\(place.formattedName)")
                .font(.title)

            if let condition = condition {
                Text("\(condition.main)")
            } else {
                Text("-")
            }
            
            Group {
                if let temperature = temperature {
                    Text(temperature.formatted)
                } else {
                    Text("-")
                }
            }
            .font(.largeTitle)
            .padding()

            Spacer()
            Spacer()
        }
    }

}

struct WeatherDetailView_Previews: PreviewProvider {

    static var previews: some View {
        WeatherDetailView(place: .nottingham, weather: .londonData)
    }

}
