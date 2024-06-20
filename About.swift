    //
    //  Index.swift
    //  SmartAisle
    //
    //  Created by Nathan Pete on 12/06/2024.
    //

import SwiftUI
import Swift
import SwiftData

struct About: View{
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack {
                HStack {
                    Text("About")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.box)
                        .frame(width: 250, height: 270)
                        .overlay(
                            Group{
                                VStack{
                                    Text("Application Version")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 0.5)
                                    
                                    Text("1.0.0")
                                        .font(.callout)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .padding(.bottom, 0.5)
                                    
                                    Text("Security Version")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 0.5)
                                    
                                    Text("1.0.0")
                                        .font(.callout)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .padding(.bottom, 0.5)
                                    
                                    Text("Copyright")
                                        .font(.title3)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 0.5)
                                    
                                    Text("\(Image(systemName: "c.circle")) NHL Stenden - 2024")
                                        .font(.callout)
                                        .foregroundColor(.accentColor)
                                        .fontDesign(.rounded)
                                }
                            })
                        .padding()
                }
                .padding()
            }
            Footer()
        }
        .ignoresSafeArea()
    }
}

