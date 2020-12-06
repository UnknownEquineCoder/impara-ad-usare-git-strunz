//
//  LearningObjectiveMyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 27/11/2020.
//

import SwiftUI

struct LearningObjectiveJourneyCell: View {
    @State private var rating = 3
    
    var isAddable = false
    var title: String
    var subtitle: String
    var core: String
    var description: String
        
    var body: some View {
            HStack {
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .background(Color("customCyan"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title.uppercased()).foregroundColor(Color.customCyan).font(.system(size: 15, weight: .semibold, design: .rounded))
                    Text(subtitle.uppercased()).foregroundColor(Color.customBlack)
                    Text(core.uppercased()).foregroundColor(Color.customBlack)
                }.padding(.leading, 20)
                
                Spacer()
                
                Text(description).foregroundColor(Color.customBlack)
                
                Spacer()
                
                if !isAddable {
                    RatingView(rating: $rating)
                } else {
                    AddButton(buttonSize: 27).padding(.trailing, 50)
                }
            }.frame(height: 100)
            .background(Color.customLightGrey)
            .cornerRadius(14)
    }
}

struct LearningObjectiveMyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        LearningObjectiveJourneyCell(title: "Design", subtitle: "", core: "", description: "")
    }
}
