//
//  Sidebar.swift
//  LJM
//
//  Created by Laura Benetti on 27/11/20.
//

import Foundation
import SwiftUI


struct Sidebar: View {
//    @State private var sections = ["Dashboard", "Journey", "Notebook", "Portfolio", "Backpack"]
//    @State private var selectedSection: String?
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(sections, id: \.self) { section in{
                    StudentPictureView(size: 130)
                        .padding(.trailing)
                    //                        Navigation(buttonName: "Dashboard", buttonIcon: "square")
                    
                    Section(header: Text("Personal").font(.system(size: 28))
                                .fontWeight(.regular)) {
                        
                        Navigation<JourneyMainView>(buttonName: "Journey", buttonIcon: "square")
//                            .onTapGesture {
//                            self.selectedSection = section
//                        }.listRowBackground(self.selectedSection == section ? Color.red : Color(UIColor.systemGroupedBackground))
                        Navigation<JourneyMainView>(buttonName: "Compass", buttonIcon: "square")
                        Navigation<JourneyMainView>(buttonName: "Notebook", buttonIcon: "square")
                    }
                    
                    Section(header: Text("Resume").font(.system(size: 28))
                                .fontWeight(.regular)) {
                        Navigation<JourneyMainView>(buttonName: "Portfolio", buttonIcon: "square")
                        Navigation<JourneyMainView>(buttonName: "Backpack", buttonIcon: "square")
                    }
                    
//                }
                }
                .background(Color("Sidebar Color"))
                .listStyle(SidebarListStyle())
                .frame(minWidth: 366)
                
                
            }
        }
        
        
    }
    struct Sidebar_Previews: PreviewProvider {
        static var previews: some View {
            Sidebar()
        }
    }

//struct MyButtonStyle: ButtonStyle {
//
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .padding()
//            .foregroundColor(.white)
//            .background(configuration.isPressed ? Color.red : Color.blue)
//            .cornerRadius(8.0)
//    }
//
//}

