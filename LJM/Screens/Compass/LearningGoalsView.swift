//
//  LearningGoalsView.swift
//  LJM
//
//  Created by Laura Benetti on 19/03/21.
//

import SwiftUI

struct LearningGoalsView: View {
    
    @State var selectedFilter = "ALL"
    @State var selectedFilterInsideButton = "All"
    @State private var searchText = ""
    @State private var selectedPath: String?
    @State private var added = false
    @State var selectedStrands = [String]()
    @State var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    @Environment(\.colorScheme) var colorScheme
    var titleView: String

    @EnvironmentObject var totalNumberLearningObjectivesStore : TotalNumberOfLearningObjectivesStore
    
    // check if filters was changed
    
    @State var isUpdated : Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                
                TitleScreenView(title: titleView)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you can take a look at all the Learning Objectives related to the Learning Goal you're looking at. Adding a Learning Objective to evaluate it will automatically add it to 'Journey' and mark it as checked in 'Map' as well.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }.frame(maxWidth: .infinity)
            
            HStack {
                
                ContextMenuFilters(fromMap: false, fromCompass: true, isUpdated: $isUpdated, selectedFilter: $selectedFilter, selectedPath: $selectedPath, selectedStrands: $selectedStrands, selectedEvaluatedOrNotFilter: $selectedEvaluatedOrNotFilter)
                
                SearchBarExpandableJourney(txtSearchBar: $searchText, isUpdated: $isUpdated)
                
            }
            
            ZStack(alignment: .top) {
                
                Text("\(self.totalNumberLearningObjectivesStore.total) Learning Objectives:")
                    .foregroundColor(Color.customDarkGrey)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("No learning objectives found ...")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 75)
                    .isHidden(self.totalNumberLearningObjectivesStore.total == 0 ? false : true)
                
                ScrollViewLearningObjectives(learningPathSelected: $selectedPath, filterCompass: selectedFilter, filterLearningGoal: titleView, filterEvaluatedOrNot: selectedEvaluatedOrNotFilter, isLearningGoalAdded: false, textFromSearchBar: $searchText, selectedStrands: selectedStrands)
                    .padding(.top, 50)
                
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
        
    }
    
}
