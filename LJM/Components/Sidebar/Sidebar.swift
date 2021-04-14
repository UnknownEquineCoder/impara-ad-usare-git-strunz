//
//  Sidebar.swift
//  LJM
//
//  Created by Laura Benetti on 27/11/20.
//

import Foundation
import SwiftUI


struct Sidebar: View {
    @State private var sections = ["Dashboard", "Journey", "Notebook", "Portfolio", "Backpack"]
    @State private var selection: Int? = 1
    
    var body: some View {
        NavigationView {
            List {

                StudentPictureView(size: 85)
                        .padding(.trailing)
                Navigation<JourneyMainView>(buttonName: "Dashboard", buttonIcon: "square", tag: 0, selection: selection)
                    
                Section(header: Text("Personal").font(.system(size: 28.toFontSize()))
                                .fontWeight(.regular)) {
                    
                        Navigation<CompassView>(buttonName: "Compass", buttonIcon: "square", tag: 1, selection: selection)
                    
                        Navigation<JourneyMainView>(buttonName: "Map", buttonIcon: "square", tag: 2, selection: selection)
                        
                        Navigation<JourneyMainView>(buttonName: "Journey", buttonIcon: "square", tag: 3, selection: selection)

                        Navigation<JourneyMainView>(buttonName: "Notebook", buttonIcon: "square", tag: 4, selection: selection)
                    }
                    
                Section(header: Text("Resume").font(.system(size: 28.toFontSize()))
                                .fontWeight(.regular)) {
                        Navigation<JourneyMainView>(buttonName: "Portfolio", buttonIcon: "square", tag: 4, selection: selection)
                        Navigation<JourneyMainView>(buttonName: "Backpack", buttonIcon: "square", tag: 5, selection: selection)
                    }
                    

                }
//                .background(Color("Sidebar Color"))
                .listStyle(SidebarListStyle())
                .frame(minWidth: 366.toScreenSize(), maxWidth: .infinity)
 
            }
        }
        
        
    }
    struct Sidebar_Previews: PreviewProvider {
        static var previews: some View {
            Sidebar()
        }
    }

