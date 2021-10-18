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
    
    @State var data_Front_Array : [CGFloat] = [0,100,80,40,20]
    @State var data_Back_Array : [CGFloat] = [20,40,80,100,0]
    
    @State var data_Path_Front_Array : [CGFloat] = [0,0,0,0,0]
    @State var data_Path_Back_Array : [CGFloat] = [0,0,0,0,0]
        
    // new data flow
   // let shared : singleton_Shared = singleton_Shared()
    //Design,Front,Back,Game,Business
    var fakePaths = ["Design", "Front","Back", "Game","Business"]
    let fake_Strands = ["App Business and Marketing","Process","Professional Skills","Technical","Design"]
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var body: some View {
        
        StackNavigationView(
            currentSubviewLabel: self.$currentSubviewLabel,
            showingSubview: self.$showingSubview,
            subviewByLabel: { label in
                self.subView(forLabel: label)
            }
        ){
            ZStack{
                
                colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white
                
                VStack {
                    HStack {
                        TitleScreenView(title: "Compass")
                            .padding(.top, 114.toScreenSize())
                            
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
                                GraphWithOverlay(data_Front_Array: $data_Front_Array, data_Back_Array: $data_Back_Array)
                                .frame(width: 395, height: 395)
                                .padding(.all, 45)
                                .padding(.bottom, 9)
                                .onAppear(perform: green_Light_Date)
                            
                            Text("Communal")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 25.toFontSize()))
                                .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                .offset(y: -50)
                            }
                            VStack{
                                GraphWithOverlay(data_Front_Array: $data_Path_Front_Array, data_Back_Array: $data_Path_Back_Array)
                                    .frame(width: 395, height: 395)
                                    .padding(.top, 45)
                                    .padding(.leading, 45)
                                    .padding(.trailing, 45)
                                    .onAppear(perform: green_Light_Path_Graph_Data)
                                
                                Text("Paths")
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25.toFontSize()))
                                    .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                DropDownMenuCompass(selectedPath: $path, fakePaths: fakePaths)
                                    .onChange(of: path) { _ in green_Light_Path_Graph_Data() }
                                    
                                
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
    
    func green_Light_Path_Graph_Data() {
        
        data_Path_Front_Array = [0,0,0,0,0]
        var path_Index = 0
        var data_Quantity = [0,0,0,0,0]
//        Design,Front,Back,Game,Business
        path_Index = fakePaths.firstIndex(of: path) ?? 1
        
        for learning_Objective in learningObjectiveStore.learningObjectives {
            
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            
            data_Path_Front_Array[temp_Strand_Index] += CGFloat(learning_Objective.core_Rubric_Levels[path_Index + 1])
            if(learning_Objective.core_Rubric_Levels[path_Index + 1] > 0){
                data_Quantity[temp_Strand_Index] += 1
            }
            
        }
        
        for index in 0...data_Quantity.count-1 {
            if(data_Path_Front_Array[index] > 0){
                data_Path_Front_Array[index] = (data_Path_Front_Array[index] / CGFloat(data_Quantity[index])) * 20
            }
        }
    }
    
    func green_Light_Date() {
        data_Front_Array = [0,0,0,0,0]
        
        var data_Quantity = [0,0,0,0,0]
        
        for learning_Objective in learningObjectiveStore.learningObjectives {
            
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            
            data_Front_Array[temp_Strand_Index] += CGFloat(learning_Objective.core_Rubric_Levels.first!)
            if(learning_Objective.core_Rubric_Levels.first! > 0){
                data_Quantity[temp_Strand_Index] += 1
            }
            
        }
        
        for index in 0...data_Quantity.count-1 {
            if(data_Front_Array[index] > 0){
                data_Front_Array[index] = (data_Front_Array[index] / CGFloat(data_Quantity[index])) * 20
            }
        }
        
    }
    
    private func dark_Light_General_Graph_Data() -> [CGFloat]{
        
        var data_Quantity = [0,0,0,0,0]
        var path_Data_Array : [CGFloat] = [0,0,0,0,0]
        
        for learning_Objective in learningObjectiveStore.learningObjectives {
            
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            
            path_Data_Array[temp_Strand_Index] += CGFloat(learning_Objective.eval_score.last ?? 0)
            data_Quantity[temp_Strand_Index] += 1
        }
        
        for index in 0...data_Quantity.count-1 {
            path_Data_Array[index] = (path_Data_Array[index] / CGFloat(data_Quantity[index]) ) * 20
        }
        
        return path_Data_Array
        
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


