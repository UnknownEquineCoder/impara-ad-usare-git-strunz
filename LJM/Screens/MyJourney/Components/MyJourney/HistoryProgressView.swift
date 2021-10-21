//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var maximumRating = 5
    var isDeletable: Bool?
    
    @State var learningObj: learning_Objective
        
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore

    var body: some View {
        
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    if number > learningObj.eval_score.last ?? 0 {
                        Circle().strokeBorder(Color.white).frame(width: 15)
                    } else {
                        Circle().fill(Color.white).frame(width: 15)
                    }
                }
            }
            // Assessment date hardcoded for now
            Text("Date test")
            
//            if self.isDeletable ?? false {
                
                let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
                
                Button(action: {
                    // Delete assessment here
                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.removeLast()
                    
                }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(Color.customBlack)
                }.buttonStyle(PlainButtonStyle())
          //  }
        }.frame(height: 30, alignment: .center)
        .padding(.leading, 10).padding(.trailing, 10)
        .background(Color.customDarkGrey)
        .cornerRadius(30 / 2)
    }
}
