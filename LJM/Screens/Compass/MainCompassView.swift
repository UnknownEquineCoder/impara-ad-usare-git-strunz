//
//  MainCompassView.swift
//  LJM
//
//  Created by denys pashkov on 08/02/22.
//

import SwiftUI

struct MainCompassView: View {
    @State var currentSubviewLabel : String? = ""
    @Binding var filter_Path : String
    @State var filter_Selected : String?
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var body: some View {
        ZStack{
            CompassView(path: $filter_Path, currentSubviewLabel: $currentSubviewLabel)
                .opacity(currentSubviewLabel == "" ? 1 : 0.00001)
            if currentSubviewLabel != "" {
                LearningGoalsView(
                    titleView: $currentSubviewLabel,
                    filter_Path: $filter_Selected, challenges: learningObjectiveStore.challenges, filtered_Learning_Objectives: learningObjectiveStore.learningObjectives.filter({$0.goal_Short.lowercased() == currentSubviewLabel!.lowercased()})
                )
            }
        }
        .onAppear {
            filter_Selected = filter_Path
        }.onChange(of: filter_Path) { newValue in
            filter_Selected = filter_Path
        }
        
    }
}

struct MainCompassView_Previews: PreviewProvider {
    static var previews: some View {
        MainCompassView( filter_Path: .constant("None") )
    }
}
