//
//  LearningObjectivePaths.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/2020.
//

import SwiftUI

struct LearningObjectivePaths: View {
    var title: String
    var subtitle: String
    var core: String
    var description: String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 20, alignment: .leading)
                .background(Color("customCyan"))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title).foregroundColor(Color("customCyan")).font(.system(size: 15, weight: .semibold, design: .rounded))
                Text(subtitle).foregroundColor(Color.black)
                Text(core).foregroundColor(Color.black)
            }
            
            Spacer()
            
            Text(description).foregroundColor(Color.black)
            
            Spacer()
            
            AddButton(buttonSize: 27)
            Spacer()
        }.frame(height: 100)
        .background(Color("customGrey"))
        .cornerRadius(14)
    }
}

struct LearningObjectivePaths_Previews: PreviewProvider {
    static var previews: some View {
        LearningObjectivePaths(title: "DESIGN", subtitle: "Prototyping", core: "Core", description: "I can create low fidelity paper prototypes and sketches.")
    }
}

