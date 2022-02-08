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
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var body: some View {
        ZStack{
            if currentSubviewLabel == ""{
                CompassView(path: $filter_Path, currentSubviewLabel: $currentSubviewLabel)
            } else {
                LearningGoalsView(
                    titleView: $currentSubviewLabel,
                    filtered_Learning_Objectives: learningObjectiveStore.learningObjectives.filter({$0.goal_Short.lowercased() == currentSubviewLabel!.lowercased()}))
            }
        }
        .padding(.top, fullScreen == true ? 60 : 0)
    }
}

struct MainCompassView_Previews: PreviewProvider {
    static var previews: some View {
        MainCompassView( filter_Path: .constant("None") )
    }
}
