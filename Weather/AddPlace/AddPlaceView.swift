//
//  AddPlaceView.swift
//  Weather
//
//  Created by Adam Young on 01/03/2021.
//

import SwiftUI
import WeatherCore

struct AddPlaceView: View {
    
    @EnvironmentObject private var model: WeatherModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        List {
            Section(header: searchHeader) {
                ForEach(model.placeResults) { place in
                    Button("\(place.formattedName)") {
                        add(place: place)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", action: dismiss)
            }
        }
        .navigationBarTitle("Add Place", displayMode: .inline)
    }
    
    private var searchHeader: some View {
        SearchBar(text: $model.placeSearchQuery)
            .font(.body)
            .foregroundColor(.primary)
            .textCase(.none)
    }

}

extension AddPlaceView {
    
    private func add(place: Place) {
        model.add(place: place)
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
        model.placeSearchQuery = ""
    }
}

struct AddPlaceView_Previews: PreviewProvider {

    static var previews: some View {
        let model = WeatherModel()
        return AddPlaceView()
            .environmentObject(model)
    }

}
