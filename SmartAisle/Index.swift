//
//  Index.swift
//  SmartAisle
//
//  Created by Nathan Pete on 12/06/2024.
//

import SwiftUI
import Swift
import SwiftData

let backgroundGradient = LinearGradient(
    colors: [.bg, .fg],
    startPoint: .bottomTrailing, endPoint: .top)


struct Index: View{
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack(alignment: .leading, spacing: 20) {
                
            }
            Footer()
        }
        .ignoresSafeArea()
    }
}

    
