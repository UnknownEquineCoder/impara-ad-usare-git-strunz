//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var maximumRating = 5
    var assessment : evaluated_Objective
    var isDeletable: Bool?
    
    @State var learningObj: learning_Objective
    
    var body: some View {
        
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    if number > assessment.score.first ?? 0 {
                        Circle().strokeBorder(Color.white).frame(width: 15)
                    } else {
                        Circle().fill(Color.white).frame(width: 15)
                    }
                }
            }
            // Assessment date hardcoded for now
            Text("12/02/21")
            
            if self.isDeletable ?? false {
                
                Button(action: {
                    // Delete assessment here
                    
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
