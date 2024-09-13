//
//  ContentView.swift
//  AR3
//
//  Created by Informatica Emmen on 21/06/2024.
//

import SwiftUI
import SwiftData


struct ContentView:View {
    var body: some View {
        HostedViewController()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
