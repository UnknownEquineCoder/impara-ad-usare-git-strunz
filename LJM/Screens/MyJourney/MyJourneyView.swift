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
    @State var selectedSort = ""
    
    let arrayFilters = ["All", "Communal", "Elective", "Evaluated", "Not Evaluated"]
    
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    @Binding var selectedMenu: OutlineMenu
    
    @Environment(\.colorScheme) var colorScheme
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore

    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "My Journey")
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "During your Journey, you will encounter a series of Learning Objectives (LOs). The Communal LOs will be added to your Journey as they are addressed in the Challenges. Elective Objectives will appear here when you select them from the Map. You can compare your Journey to specific career paths to help with personal planning. The arrows indicate your current progress towards reaching the LO.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter)
                    .padding(.top, 60)
                    .padding(.top, 120)
                
            }.frame(maxWidth: .infinity)
            
            HStack {
                DropDownMenuSort()
                    .buttonStyle(PlainButtonStyle())
                
                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: strandsStore.arrayStrandsFilter)
                    .buttonStyle(PlainButtonStyle())
                
                SearchBarExpandableJourney(txtSearchBar: $searchText)
                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
            }
            //.isHidden(self.studentLearningObj.learningObjectives.count > 0 ? false : true)
            
            ZStack(alignment: .topLeading) {
                
                NumberTotalLearningOjbectivesView(totalLOs: 30)
                  //  .isHidden(self.studentLearningObj.learningObjectives.count > 0 ? false : true)
                
                DropDownMenuSelectPath(selectedPath: $selectedPath)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                  //  .isHidden(self.studentLearningObj.learningObjectives.count > 0 ? false : true)
                
                ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedMenu: $selectedMenu)
                    .padding(.top, 50)
                
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func calculateAllLearningObjectives(learningPath: [learning_Path]) -> Int {
        return 10
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
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    @Binding var selectedMenu: OutlineMenu
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore

    var body: some View {
        
        if !checkIfMyJourneyIsEmpty() {
            ZStack(alignment: .top) {
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
//                    .isHidden(totalLOs.total > 0 ? true : false)
                    
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filterCore: selectedFilter, isAddable: false, textFromSearchBar: txtSearchBar, selectedStrands: selectedStrands)
            }
        } else {
            EmptyLearningObjectiveViewJourney(selectedMenu: $selectedMenu)
        }
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        var isEmpty = true
        if self.learningObjectiveStore.learningObjectives.isEmpty {
            isEmpty = true
        } else {
            isEmpty = false
        }
        return isEmpty
    }
}

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}
