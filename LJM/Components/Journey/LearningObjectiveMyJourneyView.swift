//
//  LearningObjectiveMyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 27/11/2020.
//

import SwiftUI

struct LearningObjectiveMyJourneyView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 20, alignment: .leading)
                .background(Color("customCyan"))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("HBJNK?L").foregroundColor(Color("customCyan")).font(.system(size: 15, weight: .semibold, design: .rounded))
                Text("IJUHYG").foregroundColor(Color.black)
                Text("kijofhsuejf").foregroundColor(Color.black)
            }
            
            Spacer()
            
            Text("Description").foregroundColor(Color.black)
            
            Spacer()
            
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
