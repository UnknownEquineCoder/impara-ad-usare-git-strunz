//
//  CompassMainView.swift
//  LJM
//
//  Created by Laura Benetti on 19/02/21.
//

import SwiftUI

struct CompassView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var path = "Game"
    @State var progressValue: Float = 10
    
    @State private var currentSubviewLabel = ""
    @State private var showingSubview = false
        
    // new data flow
    let shared : singleton_Shared = singleton_Shared()
    
    // test data
    let sampleLOs = loadCSV(from: "Grid view")
    
    var body: some View {
        
        if(showingSubview){
            subView(forLabel: currentSubviewLabel)
        } else {
            ZStack{
            
            colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white
            
            VStack {
                VStack {
                    HStack {
                        TitleScreenView(title: "Compass")
                            .padding(.top, 114.toScreenSize())
                            .onTapGesture {
                                print(self.sampleLOs)
                            }
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        DescriptionTitleScreenView(desc: "The Compass helps you to gauge your progress in meeting the Communal Learning Objectives and allows you to explore a variety of paths. Using this tool, you can plan your Learning Journey.")
                    }
                    ScrollView(showsIndicators: false){
                        DatePickerView().padding(.top, 7.toScreenSize())
                       
                        HStack{
                            InfoButton(title: "Spider Graphs: ", textBody: "The Communal graph shows progress based on the pathway all the students at the Academy have to take, while the Your Journey graph shows progress based on the specific pathway you decide to take, along with the Communal one.\n\nDepending on the Communal Expectation, the “Expectation” overlay shows you the basic progress level the Academy would like you to reach; “Your Progress”, instead, shows you the progress related to the path you decided to take.", heightCell: 241)
                            Spacer()
                            SliderView()
                            Spacer()
                        }
                        
                        HStack{
                            VStack{
                            GraphWithOverlay()
                                .frame(width: 395, height: 395)
                                .padding(.all, 45)
                                .padding(.bottom, 9)
                            
                            Text("Communal")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 25.toFontSize()))
                                .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                .offset(y: -50)
                            }
                            VStack{
                                GraphWithOverlay()
                                    .frame(width: 395, height: 395)
                                    .padding(.top, 45)
                                    .padding(.leading, 45)
                                    .padding(.trailing, 45)
                                
                                Text("Paths")
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25.toFontSize()))
                                    .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                DropDownMenuCompass(selectedPath: $path)
                                    
                                
                            }
                        }
                        HStack{
                        InfoButton(title: "Bar Graphs: ", textBody: "The bar graphs below show your growth in detail, allowing you to examine every single Learning Goal, based on the Curriculum Strands.", heightCell: 131)
                        Spacer()
                        LegendView()
                        Spacer()
                        }
                        Spacer()
                        
                        BarGraphFrame(color: Color(red: 252/255, green: 135/255, blue: 85/255), title: "Process", skills: ["Act", "Engage", "Investigate", "Ongoing Activities", "Project Management", "Scrum"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            .padding(.top, 54)
                        
                        BarGraphFrame(color: Color(red: 101/255, green: 201/255, blue: 167/255), title: "Design", skills: ["Accessibility", "Branding", "Design Fundamentals", "Game Design and Art Direction", "HIG Basics", "Prototyping", "User-Centered Design"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 252/255, green: 176/255, blue: 69/255), title: "Professional Skills", skills: ["Creative Workflow", "Collaboration", "Communication", "Employability", "Personal Growth", "Presentations", "Story Telling"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 114/255, green: 87/255, blue: 255/255), title: "Technical", skills: ["Developer Tools", "Interface Development", "Logic and Programming", "Media, Animations and Games", "Networking and Backend", "Operating Systems", "Platform Functionalities", "Supporting Frameworks"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            .padding(.top, 50)
                        
                        BarGraphFrame(color: Color(red: 172/255, green: 77/255, blue: 185/255), title: "Business", skills: ["App Business", "App Marketing", "Entrepreneurship", "Legal Guidelines", "Store Guidelines", "Store Presence", "User Engagement"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            .padding(.top, 50)
                            .padding(.bottom, 100)
                    }
                    
                    
                }
                .padding(.leading, 70).padding(.trailing, 50)
            }
        }
        }
        
//        StackNavigationView(
//            currentSubviewLabel: self.$currentSubviewLabel,
//            showingSubview: self.$showingSubview,
//            subviewByLabel: { label in
//                self.subView(forLabel: label)
//            }
//        ){
//            ZStack{
//
//            colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white
//
//            VStack {
//                VStack {
//                    HStack {
//                        TitleScreenView(title: "Compass")
//                            .padding(.top, 114.toScreenSize())
//                            .onTapGesture {
//                                print(self.sampleLOs)
//                            }
//                        Spacer()
//                    }
//
//                    VStack(alignment: .leading) {
//                        DescriptionTitleScreenView(desc: "The Compass helps you to gauge your progress in meeting the Communal Learning Objectives and allows you to explore a variety of paths. Using this tool, you can plan your Learning Journey.")
//                    }
//                    ScrollView(showsIndicators: false){
//                        DatePickerView().padding(.top, 7.toScreenSize())
//
//                        HStack{
//                            InfoButton(title: "Spider Graphs: ", textBody: "The Communal graph shows progress based on the pathway all the students at the Academy have to take, while the Your Journey graph shows progress based on the specific pathway you decide to take, along with the Communal one.\n\nDepending on the Communal Expectation, the “Expectation” overlay shows you the basic progress level the Academy would like you to reach; “Your Progress”, instead, shows you the progress related to the path you decided to take.", heightCell: 241)
//                            Spacer()
//                            SliderView()
//                            Spacer()
//                        }
//
//                        HStack{
//                            VStack{
//                            GraphWithOverlay()
//                                .frame(width: 395, height: 395)
//                                .padding(.all, 45)
//                                .padding(.bottom, 9)
//
//                            Text("Communal")
//                                .fontWeight(.medium)
//                                .multilineTextAlignment(.center)
//                                .font(.system(size: 25.toFontSize()))
//                                .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
//                                .offset(y: -50)
//                            }
//                            VStack{
//                                GraphWithOverlay()
//                                    .frame(width: 395, height: 395)
//                                    .padding(.top, 45)
//                                    .padding(.leading, 45)
//                                    .padding(.trailing, 45)
//
//                                Text("Paths")
//                                    .fontWeight(.medium)
//                                    .multilineTextAlignment(.center)
//                                    .font(.system(size: 25.toFontSize()))
//                                    .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
//                                DropDownMenuCompass(selectedPath: $path)
//
//
//                            }
//                        }
//                        HStack{
//                        InfoButton(title: "Bar Graphs: ", textBody: "The bar graphs below show your growth in detail, allowing you to examine every single Learning Goal, based on the Curriculum Strands.", heightCell: 131)
//                        Spacer()
//                        LegendView()
//                        Spacer()
//                        }
//                        Spacer()
//
//                        BarGraphFrame(color: Color(red: 252/255, green: 135/255, blue: 85/255), title: "Process", skills: ["Act", "Engage", "Investigate", "Ongoing Activities", "Project Management", "Scrum"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
//                            .padding(.top, 54)
//
//                        BarGraphFrame(color: Color(red: 101/255, green: 201/255, blue: 167/255), title: "Design", skills: ["Accessibility", "Branding", "Design Fundamentals", "Game Design and Art Direction", "HIG Basics", "Prototyping", "User-Centered Design"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
//                            .padding(.top, 50)
//
//                        BarGraphFrame(color: Color(red: 252/255, green: 176/255, blue: 69/255), title: "Professional Skills", skills: ["Creative Workflow", "Collaboration", "Communication", "Employability", "Personal Growth", "Presentations", "Story Telling"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
//                            .padding(.top, 50)
//
//                        BarGraphFrame(color: Color(red: 114/255, green: 87/255, blue: 255/255), title: "Technical", skills: ["Developer Tools", "Interface Development", "Logic and Programming", "Media, Animations and Games", "Networking and Backend", "Operating Systems", "Platform Functionalities", "Supporting Frameworks"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
//                            .padding(.top, 50)
//
//                        BarGraphFrame(color: Color(red: 172/255, green: 77/255, blue: 185/255), title: "Business", skills: ["App Business", "App Marketing", "Entrepreneurship", "Legal Guidelines", "Store Guidelines", "Store Presence", "User Engagement"], targetLabel: $currentSubviewLabel, showView: $showingSubview)
//                            .padding(.top, 50)
//                            .padding(.bottom, 100)
//                    }
//
//
//                }
//                .padding(.leading, 70).padding(.trailing, 50)
//            }
//        }
//        }
    }
    
    private func subView(forLabel label: String) -> LearningGoalsView {
        return LearningGoalsView(titleView: label)
    }
    
    private func showSubview(withLabel label: String) {
        currentSubviewLabel = label
        showingSubview = true
    }
    
}



struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}


