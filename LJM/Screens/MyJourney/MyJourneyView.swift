//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View {
    
    @State var selectedFilter = "FULL MAP"
    @State var selectedFilterInsideButton = "All"
    @State var selectedStrands = [String]()
    @State var selectedSort : SortEnum?
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    let arrayFilters = ["All", "Communal", "Elective", "Evaluated", "Not Evaluated"]
    
    @State private var searchText = ""
    @State private var selectedPath : String?
    
    @Binding var selectedMenu: OutlineMenu
    
    @Environment(\.colorScheme) var colorScheme
    
    // new data flow
    
    @EnvironmentObject var learningPathStore: LearningPathStore
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "Journey")
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "During your Journey, you will encounter a series of Learning Objectives (LOs). The Communal LOs will be added to your Journey as they are addressed in the Challenges. Elective Objectives will appear here when you select them from the Map. You can compare your Journey to specific career paths to help with personal planning. The arrows indicate your current progress towards reaching the LO.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
//                SortButtonMenu().padding(.top, 185)
//                ContextMenuFilters().padding(.top, 185).padding(.leading, 90)
//                ContextMenuFilters().padding(.top, 185).padding(.leading, 130)
                
//                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter)
//                    .padding(.top, 180)
                
            }.frame(maxWidth: .infinity)
            
            HStack {
                
                SortButtonMenu(selectedSort: $selectedSort).cursor(.pointingHand)
                ContextMenuFilters(fromMap: false, selectedFilter: $selectedFilter, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedEvaluatedOrNotFilter: $selectedEvaluatedOrNotFilter).cursor(.pointingHand)
//                DropDownMenuSort()
//                    .buttonStyle(PlainButtonStyle())
                
//                DropDownMenuFilters(selectedStrands: $selectedStrands, filterOptions: strandsStore.arrayStrandsFilter)
//                    .buttonStyle(PlainButtonStyle())
                
                SearchBarExpandableJourney(txtSearchBar: $searchText)
//                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .red)
            }
            .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
            

            ZStack(alignment: .topLeading) {
                
                NumberTotalLearningOjbectivesView(totalLOs: self.totalNumberLearningObjectivesStore.total)
                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)

//                DropDownMenuSelectPath(selectedPath: $selectedPath)
//                    .frame(maxWidth: .infinity,  alignment: .trailing)
//                    .isHidden(!checkIfMyJourneyIsEmpty() ? false : true)
                
                ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedMenu: $selectedMenu, selectedSort: $selectedSort)
                    .padding(.top, 30)
                
            }.frame(maxWidth: .infinity)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
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
                .opacity(filterTabs.count > 8 ? 1 : 0).cursor(.pointingHand)
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm)
                .offset(x: filterTabs.count < 8 ? -35 : 0).cursor(.pointingHand)
            
            ArrowButtonScrollView(vm: vm, direction: .right)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0).cursor(.pointingHand)
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    @Binding var selectedMenu: OutlineMenu
    @Binding var selectedSort: SortEnum?
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    var body: some View {
        
        if !checkIfMyJourneyIsEmpty() {
            ZStack(alignment: .top) {
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                    .isHidden(self.totalNumberLearningObjectivesStore.total > 0 ? true : false)
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filterCore: selectedFilter, filterSort: selectedSort, isAddable: false, isLearningGoalAdded: nil, textFromSearchBar: $txtSearchBar, selectedStrands: selectedStrands)
                
            }
        } else {
            EmptyLearningObjectiveViewJourney(selectedMenu: $selectedMenu)
        }
    }
    
    func checkIfMyJourneyIsEmpty() -> Bool {
        let evaluated_Objectives = self.learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
        return evaluated_Objectives.isEmpty
    }
}

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}
