//
//  WeatherPageView.swift
//  Weather
//
//  Created by Adam Young on 24/02/2021.
//

import SwiftUI

struct WeatherPageView: View {
    
    @EnvironmentObject private var model: WeatherModel
    @State private var selection: Int = -1
    @State private var isSettingsPresented = false
    
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            TabView(selection: $selection) {
                WeatherDetailView(
                    place: model.localPlace,
                    weather: model.weatherResults[model.localPlace.id]
                )
                .tabItem {
                    Text("Local Weather")
                }
                .tag(-1)
                
                ForEach(model.places) { place in
                    WeatherDetailView(
                        place: place,
                        weather: model.weatherResults[place.id]
                    )
                    .tabItem {
                        Text("\(place.name) Weather")
                    }
                    .tag(place.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .overlay(ControlsView(isSettingsPresented: $isSettingsPresented), alignment: .bottom)
        .sheet(isPresented: $isSettingsPresented) {
            NavigationView {
                PlacesView()
            }
            .environmentObject(model)
        }
        .onAppear(perform: updateWeather)
    }
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [.blue, .red]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension WeatherPageView {
    
    private func updateWeather() {
        model.fetchLocalWeather()
        model.fetchOtherWeather()
    }
    
}

struct WeatherPageView_Previews: PreviewProvider {

    static var previews: some View {
        let model = WeatherModel()
        
        return WeatherPageView()
            .environmentObject(model)
    }

}
