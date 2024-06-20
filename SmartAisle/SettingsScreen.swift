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
            HStack {
                Button(action: {
                    navigate = .home
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal)

            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    navigate = .changePassword
                }) {
                    Text("Change Password")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    navigate = .adminPanel
                }) {
                    Text("Admin Panel")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    navigate = .pairShoppingList
                }) {
                    Text("Pair Shopping Lists")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                
                Button(action: {
                    navigate = .about
                }) {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
            }
            .padding(.top, 100)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Footer(navigate: $navigate)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.12, green: 0.51, blue: 0.68))
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.27, green: 0.5, blue: 0.64)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(navigate: .constant(.settings))
    }
}
