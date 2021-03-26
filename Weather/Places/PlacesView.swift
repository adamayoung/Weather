//
//  PlacesView.swift
//  Weather
//
//  Created by Adam Young on 03/03/2021.
//

import SwiftUI
import WeatherCore

struct PlacesView: View {
    
    @EnvironmentObject private var model: WeatherModel
    @State private var isAddPlacePresented = false
    
    private var places: [Place] {
        model.places
    }
    
    var body: some View {
        List {
            ForEach(places, id: \.id) { place in
                Text("\(place.formattedName)")
            }
            .onMove(perform: movePlace)
            .onDelete(perform: removePlace)
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add", action: addPlace)
            }
        }
        .sheet(isPresented: $isAddPlacePresented) {
            NavigationView {
                AddPlaceView()
            }
            .environmentObject(model)
        }
        .navigationBarTitle("Places", displayMode: .inline)
    }

}

extension PlacesView {
    
    private func addPlace() {
        isAddPlacePresented = true
    }
    
    private func movePlace(from source: IndexSet, to destination: Int) {
        model.movePlace(from: source, to: destination)
    }
    
    private func removePlace(at offsets: IndexSet) {
        offsets.forEach { index in
            guard places.count > index else {
                return
            }

            let place = places[index]
            withAnimation {
                model.remove(place: place)
            }
            
        }
    }
    
}

struct PlacesView_Previews: PreviewProvider {

    static var previews: some View {
        PlacesView()
    }

}
