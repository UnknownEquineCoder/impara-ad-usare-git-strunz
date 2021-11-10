//
//  CompassMainView.swift
//  LJM
//
//  Created by Laura Benetti on 19/02/21.
//

import SwiftUI

struct CompassView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var path : String
    @State var progressValue: Float = 10
    
    @State private var currentSubviewLabel = ""
    @State private var showingSubview = false
    
    @State var data_Front_Array : [CGFloat] = [5,5,5,5,5]
    @State var data_Back_Array : [CGFloat] = [5,5,5,5,5]
    
    @State var data_Path_Front_Array : [CGFloat] = [5,5,5,5,5]
    @State var data_Path_Back_Array : [CGFloat] = [5,5,5,5,5]
    
    @State var animation_Trigger = false
    @State var animation_Trigger_Communal = false
    
    @State var selected_Date : Date = Date()
    
    let graph_Minimum_Dimension : CGFloat = 2
    
    
    // This will be arrays for bars graphs
    let fake_Strands = ["App Business and Marketing","Process","Professional Skills","Technical","Design"]
    
    let process_Skills = ["Act", "Engage", "Investigate ", "Ongoing Activities", "Project Management", "Scrum"]
    let design_Skills = ["Accessibility", "Branding", "Design Fundamentals", "Game Design and Art Direction", "HIG Basic", "HIG Advanced", "Prototyping", "User Centered Design"]
    let professional_Skills = ["Creative Workflow", "Collaboration", "Communication", "Employability", "Personal Growth", "Presentations", "Storytelling"]
    let tecnical_Skills = ["Developer Tools", "Interfaces Development", "Logic and Programming", "Media,  Animation and Games", "Networking and Backend", "Operating Systems", "Platform Functionalities", "Supporting Frameworks"]
    let business_Skills = ["App Business", "App Marketing", "Entrepreneurship", "Legal Guidelines", "Store Guidelines", "Store Presence", "User Engagement"]
    
    @State var process_Progress : [Double] = [5,5,5,5,5,5,5,5,5,5,5,5]
    @State var design_Progress : [Double] = [5,5,5,5,5,5,5,5,5,5,5,5]
    @State var professional_Progress : [Double] = [5,5,5,5,5,5,5,5,5,5,5,5]
    @State var tecnical_Progress : [Double] = [5,5,5,5,5,5,5,5,5,5,5,5]
    @State var business_Progress : [Double] = [5,5,5,5,5,5,5,5,5,5,5,5]
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    
    var body: some View {
        
        StackNavigationView(
            currentSubviewLabel: self.$currentSubviewLabel,
            showingSubview: self.$showingSubview,
            subviewByLabel: { label in
                self.subView(forLabel: label)
            }
        ){
            ZStack {
                
                colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color(red: 245/255, green: 245/255, blue: 245/255)
                
                VStack {
                    
//                    HStack{
//                        Button {
//                            for index in learningObjectiveStore.learningObjectives.indices {
//                                learningObjectiveStore.learningObjectives[index].eval_date = []
//                                learningObjectiveStore.learningObjectives[index].eval_score = []
//                                
//                                learningObjectiveStore.learningObjectives[index].eval_score.append(Int.random(in: 1...5))
//                                learningObjectiveStore.learningObjectives[index].eval_date.append(Date())
//                            }
//                        } label: {
//                            Text("Random Generate")
//                        }
//
//                    }
                    
                    HStack {
                        TitleScreenView(title: "Compass")
                            .padding(.top, 40)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        DescriptionTitleScreenView(desc: "The Compass helps you to gauge your progress in meeting the Communal Learning Objectives and allows you to explore a variety of paths. Using this tool, you can plan your Learning Journey.")
                    }
                    ScrollView(showsIndicators: false){
                        DatePickerView(pickerDate: $selected_Date)
                            .padding(.top, 7.toScreenSize())
                            .onChange(of: selected_Date) { date in
                                    dark_Path_Datas()
                                    dark_Core_Datas()
                            }
                       
                        HStack{
                            InfoButton(title: "Spider Graphs: ", textBody: "The Communal graph shows progress based on the pathway all the students at the Academy have to take, while the Your Journey graph shows progress based on the specific pathway you decide to take, along with the Communal one.\n\nDepending on the Communal Expectation, the “Expectation” overlay shows you the basic progress level the Academy would like you to reach; “Your Progress”, instead, shows you the progress related to the path you decided to take.", heightCell: 241)
                            Spacer()
//                            SliderView()
                            Spacer()
                        }
                        
                        HStack{
                            VStack{
                                
                                CoreRadarChartView(data_Front_Array: $data_Front_Array, data_Back_Array: $data_Back_Array, animation_Trigger: $animation_Trigger_Communal)
                                .frame(width: 395, height: 395)
                                .padding(.all, 45)
                                .padding(.bottom, 9)
                                .onAppear {
                                    dark_Core_Datas()
                                    dark_Path_Datas()
                                    green_Light_Date()
                                    animation_Trigger = true
                                    animation_Trigger_Communal = true
                                    test_Idea_Function()
                                }
                            
                            Text("Communal")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 25.toFontSize()))
                                .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                .offset(y: -50)
                            }
                            VStack{
                                GraphWithOverlay(data_Front_Array: $data_Path_Front_Array, data_Back_Array: $data_Path_Back_Array, animation_Trigger: $animation_Trigger)
                                    .frame(width: 395, height: 395)
                                    .padding(.top, 25)
                                    .padding(.leading, 45)
                                    .padding(.trailing, 45)
                                    .onAppear(perform: green_Light_Path_Graph_Data)
                                
                                Text("Paths")
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25.toFontSize()))
                                    .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 129/255, green: 129/255, blue: 129/255))
                                
                                DropDownMenuCompass(selectedPath: $path)
                                    .onChange(of: path) { _ in
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            animation_Trigger = false
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            green_Light_Path_Graph_Data()
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            animation_Trigger = true
                                        }
                                    }
                                    
                                
                            }
                        }
                        HStack{
                        
                        Spacer()
                        LegendView()
                        Spacer()
                        }.padding(.bottom, 20)
                        HStack{
                            InfoButtonBarGraph(title: "Bar Graphs: ", textBody: "The bar graphs below show your growth in detail, allowing you to examine every single Learning Goal, based on the Curriculum Strands.", heightCell: 131)
                            
                            Spacer()
                        }
                        Spacer()
                        
                        Group{
                            BarGraphFrame(color: Color.customOrange, title: "Process", skills: process_Skills, progress: $process_Progress, targetLabel: $currentSubviewLabel, showView: $showingSubview)
                            
                            BarGraphFrame(color: Color.customGreen, title: "Design", skills: design_Skills, progress: $design_Progress, targetLabel: $currentSubviewLabel, showView: $showingSubview)
                                .padding(.top, 50)
                            
                            BarGraphFrame(color: Color.customYellow, title: "Professional Skills", skills: professional_Skills, progress: $professional_Progress, targetLabel: $currentSubviewLabel, showView: $showingSubview)
                                .padding(.top, 50)
                            
                            BarGraphFrame(color: Color.customBlue, title: "Technical", skills: tecnical_Skills, progress: $tecnical_Progress, targetLabel: $currentSubviewLabel, showView: $showingSubview)
                                .padding(.top, 50)
                            
                            BarGraphFrame(color: Color.customPurple, title: "Business", skills: business_Skills, progress: $business_Progress, targetLabel: $currentSubviewLabel, showView: $showingSubview)
                                .padding(.top, 50)
                                .padding(.bottom, 100)
                        }
                        
                        
                    }
                }
                .padding(.leading, 70).padding(.trailing, 50)
            }
        }
    }
    
    func test_Idea_Function(){
        
        let process_Skills_Count = process_Skills.count
        let design_Skills_Count = design_Skills.count
        let professional_Skills_Count = professional_Skills.count
        let tecnical_Skills_Count = tecnical_Skills.count
        let business_Skills_Count = business_Skills.count
        
        process_Progress = (0 ..< process_Skills_Count).map { _ in 0 }
        var process_Progress_Quantity : [Int] = (0 ..< process_Skills_Count).map { _ in 0 }
        design_Progress = (0 ..< design_Skills_Count).map { _ in 0 }
        var design_Progress_Quantity : [Int] = (0 ..< design_Skills_Count).map { _ in 0 }
        professional_Progress = (0 ..< professional_Skills_Count).map { _ in 0 }
        var professional_Progress_Quantity : [Int] = (0 ..< professional_Skills_Count).map { _ in 0 }
        tecnical_Progress = (0 ..< tecnical_Skills_Count).map { _ in 0 }
        var tecnical_Progress_Quantity : [Int] = (0 ..< tecnical_Skills_Count).map { _ in 0 }
        business_Progress = (0 ..< business_Skills_Count).map { _ in 0 }
        var business_Progress_Quantity : [Int] = (0 ..< business_Skills_Count).map { _ in 0 }
        
        for learning_Objective in learningObjectiveStore.learningObjectives {
            switch learning_Objective.strand {
                case "App Business and Marketing":

                    let element_Index = business_Skills.firstIndex(of: learning_Objective.goal_Short) ?? 0
                    business_Progress[element_Index] += Double(learning_Objective.eval_score.last ?? 0)
                    business_Progress_Quantity[element_Index] += 1
                    break

                case "Process":

                    let element_Index = process_Skills.firstIndex(of: learning_Objective.goal_Short) ?? 0
                    process_Progress[element_Index] += Double(learning_Objective.eval_score.last ?? 0)
                    process_Progress_Quantity[element_Index] += 1
                    break

                case "Professional Skills":

                    let element_Index = professional_Skills.firstIndex(of: learning_Objective.goal_Short) ?? 0
                    professional_Progress[element_Index] += Double(learning_Objective.eval_score.last ?? 0)
                    professional_Progress_Quantity[element_Index] += 1
                    break

                case "Technical":

                    let element_Index = tecnical_Skills.firstIndex(of: learning_Objective.goal_Short) ?? 0
                    tecnical_Progress[element_Index] += Double(learning_Objective.eval_score.last ?? 0)
                    tecnical_Progress_Quantity[element_Index] += 1
                    break

                case "Design":
                let element_Index = design_Skills.firstIndex(where: { $0.lowercased() == learning_Objective.goal_Short.lowercased()}) ?? 0
                
                    design_Progress[element_Index] += Double(learning_Objective.eval_score.last ?? 0)
                    design_Progress_Quantity[element_Index] += 1
                    break

                default:
                    break
            }
        }
        
        for index in 0 ..< process_Skills_Count {
            if(process_Progress_Quantity[index] > 0){
                process_Progress[index] = (process_Progress[index] / CGFloat(process_Progress_Quantity[index]))
            }
        }
        for index in 0 ..< design_Skills_Count {
            if(design_Progress_Quantity[index] > 0){
                design_Progress[index] = (design_Progress[index] / CGFloat(design_Progress_Quantity[index]))
            }
        }
        for index in 0 ..< professional_Skills_Count {
            if(professional_Progress_Quantity[index] > 0){
                professional_Progress[index] = (professional_Progress[index] / CGFloat(professional_Progress_Quantity[index]))
            }
        }
        for index in 0 ..< tecnical_Skills_Count {
            if(tecnical_Progress_Quantity[index] > 0){
                tecnical_Progress[index] = (tecnical_Progress[index] / CGFloat(tecnical_Progress_Quantity[index]))
            }
        }
        for index in 0 ..< business_Skills_Count {
            if(business_Progress_Quantity[index] > 0){
                business_Progress[index] = (business_Progress[index] / CGFloat(business_Progress_Quantity[index]))
            }
        }
    }
    
    func green_Light_Path_Graph_Data() {
        
        data_Path_Front_Array = [0,0,0,0,0]
        var path_Index = 0
        var data_Quantity = [0,0,0,0,0]
        path_Index = learningPathStore.learningPaths.firstIndex(where: {$0.title == path}) ?? 1
        
        // filter for tonio cartonio
        let filtered_Objectives = learningObjectiveStore.learningObjectives.filter({ ($0.core_Rubric_Levels[path_Index + 1] * $0.core_Rubric_Levels[0]) > 1})

        for learning_Objective in filtered_Objectives {
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            data_Path_Front_Array[temp_Strand_Index] += (learning_Objective.core_Rubric_Levels[path_Index + 1] > learning_Objective.core_Rubric_Levels[0]) ?  CGFloat(learning_Objective.core_Rubric_Levels[path_Index + 1]) : CGFloat(learning_Objective.core_Rubric_Levels[0])
            data_Quantity[temp_Strand_Index] += 1
        }
        
        for index in 0...data_Quantity.count-1 {
            if(data_Path_Front_Array[index] > 0){
                data_Path_Front_Array[index] = (data_Path_Front_Array[index] / CGFloat(data_Quantity[index])) * 20
            }
            
            if data_Path_Front_Array[index] <= graph_Minimum_Dimension {
                data_Path_Front_Array[index] = graph_Minimum_Dimension
            }
        }
    }
    
    func green_Light_Date() {
        data_Front_Array = [60,60,60,60,60]
        
//        var data_Quantity = [0,0,0,0,0]
//
//        let filtered_Learning_Objective = learningObjectiveStore.learningObjectives.filter({$0.isCore})
//
//        for learning_Objective in filtered_Learning_Objective {
//
//            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
//
//            data_Front_Array[temp_Strand_Index] += CGFloat(learning_Objective.core_Rubric_Levels.first!)
//            data_Quantity[temp_Strand_Index] += 1
//
//        }
//
//        for index in 0...data_Quantity.count-1 {
//            if(data_Front_Array[index] > 0){
//                data_Front_Array[index] = (data_Front_Array[index] / CGFloat(data_Quantity[index])) * 20
//            }
//
//            if data_Front_Array[index] <= graph_Minimum_Dimension {
//                data_Front_Array[index] = graph_Minimum_Dimension
//            }
//        }
        
    }
    
    func dark_Core_Datas() {

        data_Back_Array = [0,0,0,0,0]
        
        var data_Quantity = [0,0,0,0,0]
        
        let filtered_Learning_Objective = learningObjectiveStore.learningObjectives.filter({$0.isCore})
        
        for learning_Objective in filtered_Learning_Objective {
            
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            if((learning_Objective.eval_score.last ?? 0) > 0){
                
                let data_Filtered_Index = closestMatch(values: learning_Objective.eval_date, inputValue: selected_Date)
                
                if(data_Filtered_Index != -1){
                    var score = CGFloat(learning_Objective.eval_score.last ?? 0)
                    
                    if score > 3 {
                        score = 3
                    }
                    
                    data_Back_Array[temp_Strand_Index] += score
                }
                
            }
            
            data_Quantity[temp_Strand_Index] += 1
            
        }
        
        for index in 0...data_Quantity.count-1 {
            if(data_Back_Array[index] > 0){
                data_Back_Array[index] = (data_Back_Array[index] / CGFloat(data_Quantity[index])) * 20
            }
            
            if(data_Back_Array[index] <= graph_Minimum_Dimension){
                data_Back_Array[index] = graph_Minimum_Dimension
            }
        }
    }
    
    private func dark_Path_Datas(){
        
        data_Path_Back_Array = [0,0,0,0,0]
        
        var data_Quantity = [0,0,0,0,0]
        
        let filtered_Learning_Objective = learningObjectiveStore.learningObjectives
        
        for learning_Objective in filtered_Learning_Objective {
            let temp_Strand_Index = fake_Strands.firstIndex(of: learning_Objective.strand) ?? 0
            if((learning_Objective.eval_score.last ?? 0) > 0){
                
                let data_Filtered_Index = closestMatch(values: learning_Objective.eval_date, inputValue: selected_Date)
                
                if(data_Filtered_Index != -1){
                
                    data_Path_Back_Array[temp_Strand_Index] += CGFloat(learning_Objective.eval_score.last ?? 0)
                    
                }
            }
            
            data_Quantity[temp_Strand_Index] += 1
            
        }
        
        for index in 0...data_Quantity.count-1 {
            if(data_Path_Back_Array[index] > 0){
                data_Path_Back_Array[index] = (data_Path_Back_Array[index] / CGFloat(data_Quantity[index])) * 20
            }
            
            if(data_Path_Back_Array[index] <= graph_Minimum_Dimension){
                data_Path_Back_Array[index] = graph_Minimum_Dimension
            }
        }
    }
    
    private func subView(forLabel label: String) -> LearningGoalsView {
        return LearningGoalsView(titleView: label)
    }
    
    private func showSubview(withLabel label: String) {
        currentSubviewLabel = label
        showingSubview = true
    }
    
    func closestMatch(values: [Date], inputValue: Date) -> Int {
        
        let possible_Index = values.firstIndex(where: {$0 > inputValue} )
        
        if let found_Index = possible_Index {
            if found_Index == 0{ return -1 }
            return found_Index - 1
        } else {
            return values.count - 1
        }
    }
}


