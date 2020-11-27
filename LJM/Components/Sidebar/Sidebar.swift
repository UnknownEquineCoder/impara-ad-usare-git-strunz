//
//  Sidebar.swift
//  LJM
//
//  Created by Laura Benetti on 27/11/20.
//

import Foundation
import SwiftUI


struct Sidebar: View {
    
    var body: some View {
        NavigationView {
                    List {
                        
                        StudentPictureView(size: 60)
                            .padding(.trailing)
                        Navigation(buttonName: "Dashboard", buttonIcon: "square")
                        
                        Section(header: Text("Personal")) {
                            Navigation(buttonName: "Journey", buttonIcon: "square")
                            Navigation(buttonName: "Compass", buttonIcon: "square")
                            Navigation(buttonName: "Notebook", buttonIcon: "square")
                                   }
                        Section(header: Text("Resume")) {
                            Navigation(buttonName: "Portfolio", buttonIcon: "square")
                            Navigation(buttonName: "Backpack", buttonIcon: "square")
                                   }

                    }
                    .listStyle(SidebarListStyle())
                    .frame(minWidth: 180, idealWidth: 200, maxWidth: .infinity)
                }
        }
    }
    struct Sidebar_Previews: PreviewProvider {
        static var previews: some View {
            Sidebar()
        }
    }

