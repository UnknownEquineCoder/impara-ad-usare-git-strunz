//
//  ScrollViewLearningObjectives.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct ScrollViewLearningObjectives: View {
    @Environment(\.colorScheme) var colorScheme
    
    var learningPathSelected : String?
    
    var isAddable = false
    var isLearningGoalAdded: Bool?
    
    @Binding var textFromSearchBar: String
    
    @Binding var filtered_Learning_Objectives : [learning_Objective]
    
    var body: some View {
        if #available(macOS 12, *) {
            LazyVStack(spacing: 20) {
                ForEach(filtered_Learning_Objectives, id: \.ID) { item in
                    LearningObjectiveJourneyCell(
                        rating: item.eval_score.last ?? 0,
                        isRatingView: item.eval_score.count > 0,
                        filter_Text: $textFromSearchBar,
                        isAddable: isAddable,
                        isLearningGoalAdded: isLearningGoalAdded == nil ? nil : (isLearningGoalAdded ?? false && item.eval_score.count > 0),
                        learningPathSelected: learningPathSelected,
                        learningObj: item)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
        } else {
            // FOR BIG SUR AT LEAST
            
            VStack {
                List(filtered_Learning_Objectives, id: \.ID) {
                    item in
                    LearningObjectiveJourneyCell(
                        rating: item.eval_score.last ?? 0,
                        isRatingView: item.eval_score.count > 0,
                        filter_Text: $textFromSearchBar,
                        isAddable: isAddable,
                        isLearningGoalAdded: isLearningGoalAdded == nil ? nil : (isLearningGoalAdded ?? false && item.eval_score.count > 0),
                        learningPathSelected: learningPathSelected,
                        learningObj: item)
                }
                .frame(minHeight: 600, maxHeight: .infinity)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
    }
}


