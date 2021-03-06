//
//  CompassMainView.swift
//  LJM
//
//  Created by Laura Benetti on 19/02/21.
//

import SwiftUI

struct CompassView: View, LJMView {
    @Environment(\.colorScheme) var colorScheme
    @State var path = "UI/UX"
    @State var progressValue: Float = 10
    
    var body: some View {
        
        ZStack{
            
            colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white
            
            VStack {
                VStack {
                    HStack {
                        TitleScreenView(title: "Compass")
                            .padding(.top, 114.toScreenSize())
                        
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        DescriptionTitleScreenView(desc: "Compass is your personal progress tracking tool. Here you are able to have a panoramic view of your personal progress.")
                    }
                    ScrollView(showsIndicators: false){
                        DatePickerView().padding(.top, 7.toScreenSize())
                        
                        SliderView()
                        
                        HStack{
                            Spacer()
                            VStack{
                                GraphWithOverlay()
                                    .frame(width: 395, height: 395)
                                    .padding(.all, 45)
                                
                                DropDownMenuCompass(selectedPath: $path)
                            }
                            Spacer(minLength: 214)
                            
                            GraphWithOverlay()
                                .frame(width: 395, height: 395)
                                .padding(.all, 45)
                            
                            Spacer()
                        }
                        LegendView()
                        
                        Spacer()
                        
                        BarGraphFrame(color: Color(red: 252/255, green: 135/255, blue: 85/255), title: "Process", skills: ["Act", "Engage", "Investigate", "Ongoing Activities", "Project Management", "Scrum"])
                            .padding(.top, 54)
                        
                        BarGraphFrame(color: Color(red: 101/255, green: 201/255, blue: 167/255), title: "Design", skills: ["Accessibility", "Branding", "Design Fundamentals", "Game Design and Art Direction", "HIG Basics", "Prototyping", "User-Centered Design"])
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 252/255, green: 176/255, blue: 69/255), title: "Professional Skills", skills: ["Creative Workflow", "Collaboration", "Communication", "Employability", "Personal Growth", "Presentations", "Story Telling"])
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 114/255, green: 87/255, blue: 255/255), title: "Technical", skills: ["Developer Tools", "Interface Development", "Logic and Programming", "Media, Animations and Games", "Networking and Backend", "Operating Systems", "Platform Functionalities", "Supporting Frameworks"])
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 172/255, green: 77/255, blue: 185/255), title: "Business", skills: ["App Business", "App Marketing", "Entrepreneurship", "Legal Guidelines", "Store Guidelines", "Store Presence", "User Engagement"])
                            .padding(.top, 50)
                            .padding(.bottom, 100)
                    }
                    
                    
                }
                .padding(.leading, 70).padding(.trailing, 50)
            }
            
            .frame(minHeight: 1080.toScreenSize())
            
            
        }
    }
}



struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}


