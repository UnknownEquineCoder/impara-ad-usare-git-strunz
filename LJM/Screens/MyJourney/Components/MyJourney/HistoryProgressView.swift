//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    @Environment(\.colorScheme) var colorScheme

    var maximumRating = 5
    let dateFormatter = DateFormatter()
    @Binding var rating: Int
    
    var dateValue: String {
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: learning_Date)
    }
    
    let learning_Score : Int
    let learning_Date : Date
    let learning_ID : String
    let index : Int
    
//    @State var learningObj: learning_Objective
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var body: some View {
        
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    if number > learning_Score {
                        Circle().strokeBorder(Color.white).frame(width: 15)
                    } else {
                        Circle().fill(Color.white).frame(width: 15)
                    }
                }
            }
            
            Text(dateValue)
                .foregroundColor(Color.white)
            
            let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learning_ID})!
            
            if !(index == 0) {
                Button(action: {
                    
                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.remove(at: index)
                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.remove(at: index)

                    self.rating = self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.last ?? 0

                }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(Color.white)
                }.buttonStyle(PlainButtonStyle()).cursor(.pointingHand)
            }
        }.frame(height: 30, alignment: .center)
            .padding(.leading, 10).padding(.trailing, 10)
            .background(Color.customGrey)
            .cornerRadius(30 / 2)
    }
}
