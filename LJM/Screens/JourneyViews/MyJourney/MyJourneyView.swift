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
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    
    @ObservedObject var totalLOs : TotalNumberLearningObjectives
    
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
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: setupStrandsOnFilter(strands: self.strandsStore.strands))
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, totalLOs: totalLOs, selectedSegmentView: self.selectedView)
                    .padding(.top, 50)
                
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    
    func calculateAllLearningObjectives(learningPath: [LearningPath]) -> Int {
        return 10
    }
    
    func setupStrandsOnFilter(strands: [String]) -> [FilterChoice] {
        
        var arrayStrandsFilter = [FilterChoice]()
        
        for strand in strands {
            arrayStrandsFilter.append(FilterChoice(descriptor: strand))
        }
        
        return arrayStrandsFilter
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
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm)
                .offset(x: filterTabs.count < 8 ? -35 : 0)
            
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
        
        if studentLearningObjectivesStore.learningObjectives.count > 0 {
            ZStack(alignment: .top) {
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                    .isHidden(totalLOs.total > 0 ? true : false)
                                
                ScrollViewLearningObjectives(totalLOs: self.totalLOs, selectedSegmentView: selectedSegmentView, learningPathSelected: selectedPath, filterCore: selectedFilter, isAddable: false, textFromSearchBar: txtSearchBar, selectedStrands: selectedStrands)
            }
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
