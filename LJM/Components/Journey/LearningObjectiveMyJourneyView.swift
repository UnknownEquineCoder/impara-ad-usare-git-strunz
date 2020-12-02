//
//  LearningObjectiveMyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 27/11/2020.
//

import SwiftUI

struct LearningObjectiveMyJourneyView: View {
    @State private var rating = 3
        
    var body: some View {
            HStack {
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .background(Color("customCyan"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("DESIGN").foregroundColor(Color("customCyan")).font(.system(size: 15, weight: .semibold, design: .rounded))
                    Text("PROTOTYPING").foregroundColor(Color.black)
                    Text("CORE").foregroundColor(Color.black)
                }.padding(.leading, 20)
                
                Spacer()
                
                Text("I can create low fidelity paper prototypes and sketches").foregroundColor(Color.black)
                
                Spacer()
                
                RatingView(rating: $rating)
                
            }.frame(height: 100)
            .background(Color("customGrey"))
            .cornerRadius(14)
        
    }
}

struct LearningObjectiveMyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        LearningObjectiveMyJourneyView()
    }
}
