//
//  Styling.swift
//  Testing2
//
//  Created by Nathan Pete on 02/08/2024.
//

import SwiftUI
import Swift

let backgroundGradient = LinearGradient(
    colors: [.bg, .fg],
    startPoint: .bottom, endPoint: .top)

struct CustomTextField: View {
    let systemImageName: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundColor(.black)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .fontDesign(.rounded)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .fontDesign(.rounded)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 5)
        .fontDesign(.rounded)

    }
}
