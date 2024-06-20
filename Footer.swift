//
//  ContentView.swift
//  SmartAisle
//
//  Created by Nathan Pete on 06/06/2024.
//

import SwiftUI
import SwiftData
import Swift

struct Footer: View {
    
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        TabView (selection: $currentTab){
            
        }
        .overlay(
            HStack (spacing: 0) {
                ForEach (Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
                
                .padding(.vertical)
                .padding(.bottom, getSafeArea().bottom == 0 ? 5 :
                            (getSafeArea().bottom))
                
                .background(Color("navBarBg"))
            },
            alignment: .bottom
        ).ignoresSafeArea(.all,edges: .bottom)
    }
    
    func TabButton(tab: Tab) -> some View {
        GeometryReader{ proxy in
            
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = tab
                }
            }, label: {
                VStack(spacing: 0){
                    Image(systemName: currentTab == tab ?
                          tab.rawValue + ".fill" : tab.rawValue)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            Text(tab.tabName).foregroundColor(.accentColor)
                                .font(.footnote).padding(.top, 50)
                                .fontDesign(.rounded)
                        }
                    )
                }
            })
        }
        .frame(height: 30)
    }
}

#Preview {
    Footer()
        
}

//Navbar

enum Tab: String, CaseIterable{
    case Home = "house"
    case List = "list.bullet.rectangle"
    case Catalogue = "book"
    case ARScanner = "opticid"
    case Settings = "gearshape"
    
    var tabName: String {
        switch self {
        case .Home:
            return "Index"
        case .List:
            return "List"
        case .Catalogue:
            return "Catalogue"
        case .ARScanner:
            return "Scanner"
        case .Settings:
            return "Settings"
        }
    }
}


extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
    
        guard  let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
