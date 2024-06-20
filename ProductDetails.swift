    //
    //  Settings.swift
    //  SmartAisle
    //
    //  Created by Nathan Pete on 12/06/2024.
    //

import SwiftUI
import Swift
import SwiftData

struct ProductDetails: View{
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack {
                HStack {
                    Text("Product Name")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Button(action: {}, label:{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 250)
                            .overlay(
                                Image(systemName: "lock.doc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            )
                    })
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.box)
                        .frame(width: 150, height: 75)
                        .overlay(
                            Text("Back")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                        )
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.box)
                        .frame(width: 150, height: 75)
                        .overlay(
                            Text("Add to Cart")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                        )
                }
                .padding()
            }
            Footer()
        }
        .ignoresSafeArea()
    }
}

