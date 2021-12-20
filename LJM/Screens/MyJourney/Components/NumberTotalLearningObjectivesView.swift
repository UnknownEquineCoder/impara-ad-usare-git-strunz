//
//  NumberTotalLearningOjbectivesView.swift
//  LJM
//
//  Created by Tony Tresgots on 10/02/2021.
//

import SwiftUI

struct NumberTotalLearningObjectivesView: View {
    
    var totalLOs : Int?
    
    var body: some View {
        Text("\(totalLOs ?? 0) Learning Objectives:")
            .foregroundColor(Color.customDarkGrey)
            .font(.system(size: 15, weight: .medium, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct NumberTotalLearningOjbectivesView_Previews: PreviewProvider {
    static var previews: some View {
        NumberTotalLearningObjectivesView()
    }
}
