//
//  LearningGoalsView.swift
//  LJM
//
//  Created by Laura Benetti on 19/03/21.
//

import SwiftUI

struct LearningGoalsView: View {
    
    let arrayFilters = ["All", "Core", "Elective", "Evaluated"]
    @State var selectedFilter = "All"
    @State var selectedFilterInsideButton = "All"
    @State private var searchText = ""
    @State private var selectedPath = ""
    @State var selectedStrands = [String]()
    @Environment(\.colorScheme) var colorScheme
    var titleView: String
    
//    @EnvironmentObject var learningPathsStore: LearningPathStore
//    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
//    @EnvironmentObject var strandsStore: StrandsStore
//
//    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    //@ObservedObject var selectedView : SelectedSegmentView
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                Spacer()
                
                TitleScreenView(title: titleView)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you can take a look at all the Learning Objectives related to the Learning Goal you're looking at. Adding a Learning Objective to evaluate it will automatically add it to 'My Journey' and mark it as checked in 'Map' as well.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                
                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter)
                    .padding(.top, 20)
                    .padding(.top, 120)
                
            }.frame(maxWidth: .infinity)
            
            ZStack(alignment: .topLeading) {
                
                Text("Learning Objective Related:") .foregroundColor(Color.customDarkGrey)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //ListViewLearningObjectiveMyJourney(selectedFilter: $selectedFilter, txtSearchBar: $searchText, selectedPath: $selectedPath, selectedStrands: $selectedStrands, totalLOs: totalLOs, selectedSegmentView: self.selectedView)
                    //.padding(.top, 50)
                    
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
}



struct LearningGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningGoalsView(titleView: "Marina")
    }
}
