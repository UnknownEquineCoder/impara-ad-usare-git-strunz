//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View {
    
    @State var selectedFilter = "All"
    @State var selectedFilterInsideButton = "All"
    @State var selectedStrands = [String]()

    let arrayFilters = ["All", "Core", "Elective", "Evaluated"]
    
    @State private var searchText = ""
    @State private var selectedPath = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var learningPathsStore: LearningPathStore

    @StateObject var studentLearningObjectivesStore = StudentLearningObjectivesStore()
    
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    @ObservedObject var selectedView : SelectedSegmentView
        
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "My Journey")
                
                DropDownMenuSelectPath(selectedPath: $selectedPath)
                    .padding(.leading, 250)
                    .padding(.top, 23)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter)
                    .padding(.top, 20)
                    .padding(.top, 120)
                
            }.frame(maxWidth: .infinity)
            
            ZStack(alignment: .topLeading) {
                
               // NumberTotalLearningOjbectivesView(totalLOs: calculateAllLearningObjectives(learningPath: learningPaths))
                NumberTotalLearningOjbectivesView(totalLOs: self.totalLOs.total)
                
                TestButtons().padding(.leading, 200)
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters(selectedStrands: $selectedStrands)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, totalLOs: totalLOs, selectedSegmentView: self.selectedView)
                    .padding(.top, 50)
                    
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
        .environmentObject(studentLearningObjectivesStore)
    }
    
    
    func calculateAllLearningObjectives(learningPath: [LearningPath]) -> Int {
        return 10
    }
}

struct TestButtons: View {
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore

    var body: some View {
        HStack {
            Button(action: {
                Webservices.getAllLearningPaths { learningPathResult, err  in
                    for learningPath in learningPathResult {
                        learningPathsStore.addItem(learningPath)
                    }
                }
            }) {
                Text("Get")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                    Webservices.getStudentJourneyLearningObjectives { (learningObjectives, err) in
                        for learningObjective in learningObjectives {
                            studentLearningObjectivesStore.addItem(learningObjective)
                        }
                    }
            }) {
                Text("Get LOs")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct ScrollViewFiltersJourney: View {
    var filterTabs : [String]
    @Binding var selectedFilter : String
    @StateObject var vm = ScrollToModel()
    
    var body: some View {
        HStack {
            ArrowButtonScrollView(vm: vm, direction: .left)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0)
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm).offset(x: filterTabs.count < 8 ? -35 : 0)
            
            ArrowButtonScrollView(vm: vm, direction: .right)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0)
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    @Binding var selectedPath : String
    @Binding var selectedStrands : [String]
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    @ObservedObject var selectedSegmentView : SelectedSegmentView
    
    var body: some View {
        
        if learningPathsStore.learningPaths.count > 0 {
            ScrollViewLearningObjectives(totalLOs: self.totalLOs, learningPathSelected: selectedPath, filterCore: selectedFilter, isAddable: false, textFromSearchBar: txtSearchBar, selectedStrands: selectedStrands)
        } else {
            EmptyLearningObjectiveViewJourney(selectedView: self.selectedSegmentView)
        }
    }
}

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}
