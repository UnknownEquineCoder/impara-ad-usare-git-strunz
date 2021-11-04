//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var maximumRating = 5
    var index: Int
    let dateFormatter = DateFormatter()
    @Binding var rating: Int
    
    var dateValue: String {
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: learningObj.eval_date[index])
    }
    
    @State var learningObj: learning_Objective
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var body: some View {
        
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    if number > learningObj.eval_score[index] {
                        Circle().strokeBorder(Color.white).frame(width: 15)
                    } else {
                        Circle().fill(Color.white).frame(width: 15)
                    }
                }
            }
            
            Text(dateValue)
            
            let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
            
            if !(index == 0) {
                Button(action: {
                    // Delete assessment here
                    print("IUHJOK \(index)")
                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.remove(at: index)
                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.remove(at: index)
                    
                    self.rating = self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.last ?? 0

                }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(Color.customBlack)
                }.buttonStyle(PlainButtonStyle())
            }
        }.frame(height: 30, alignment: .center)
            .padding(.leading, 10).padding(.trailing, 10)
            .background(Color.customDarkGrey)
            .cornerRadius(30 / 2)
    }
}
