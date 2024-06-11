//
//  SettingsScreen.swift
//  SmartAisle
//
//  Created by Abu Hasib on 09/06/2024.
//

import SwiftUI

struct SettingsScreen: View {
    @Binding var navigate: Screen
    
    var body: some View {
        VStack {
            Text("Settings Screen")
            Button("Go to Home") {
                navigate = .home
            }
        }
    }
}
