//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var maximumRating = 5
    var assessment : Assessment
    
    @State var learningObj: LearningObjective
    
    var body: some View {
        
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    if number > assessment.score?.rawValue ?? 0 {
                        Circle().strokeBorder(Color.white).frame(width: 15)
                    } else {
                        Circle().fill(Color.white).frame(width: 15)
                    }
                }
            }
            
            Text(self.assessment.date)
            
            Button(action: {
                
                    Webservices.deleteAssessment(id: self.assessment.id) { (assessment, err) in
                        // UPDATE UI DELETED HISTORY
//                        self.learningObj.getAssessments()
                    }
                
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(Color.customBlack)
            }.buttonStyle(PlainButtonStyle())
        }.frame(height: 30, alignment: .center)
        .padding(.leading, 10).padding(.trailing, 10)
        .background(Color.customDarkGrey)
        .cornerRadius(30 / 2)
    }
}
