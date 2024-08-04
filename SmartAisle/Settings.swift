    //
    //  Settings.swift
    //  SmartAisle
    //
    //  Created by Nathan Pete on 12/06/2024.
    //

import SwiftUI
import Swift
import SwiftData

struct Settings: View{
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack {
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Button(action: {}, label:{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Change Password")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                                
                            )
                    })
                }
                .padding()
                
                HStack {
                    Button(action: {}, label:{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("Pair Shopping Lists")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                    })
                }
                
                NavigationLink(destination: About()){
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.box)
                            .frame(width: 225, height: 75)
                            .overlay(
                                Text("About")
                                    .font(.title3)
                                    .foregroundColor(.accentColor)
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                            )
                    }
                }
                .padding()
            }
            Footer()
        }
        .ignoresSafeArea()
    }
}

