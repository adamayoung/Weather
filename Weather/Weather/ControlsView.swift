//
//  ControlsView.swift
//  Weather
//
//  Created by Adam Young on 24/02/2021.
//

import SwiftUI

struct ControlsView: View {
    
    @Binding var isSettingsPresented: Bool

    var body: some View {
        HStack {
            Spacer()
            Button(action: showSettings) {
                Label("Settings", systemImage: "list.dash")
                    .labelStyle(IconOnlyLabelStyle())
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal)
    }

}

extension ControlsView {
    
    private func showSettings() {
        isSettingsPresented = true
    }
    
}

struct ControlsView_Previews: PreviewProvider {

    static var previews: some View {
        ControlsView(isSettingsPresented: .constant(true))
    }

}
