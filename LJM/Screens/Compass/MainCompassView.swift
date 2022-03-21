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
                .onAppear(perform: {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        if let peppe = sendToDropbox() {
                            DropboxManager.instance.checkForUploadUserData(peppe)
                        }
                    }
                })
            if currentSubviewLabel != "" {
                LearningGoalsView(
                    titleView: $currentSubviewLabel,
                    filter_Path: filter_Selected, challenges: learningObjectiveStore.getChallenges(), filtered_Learning_Objectives: learningObjectiveStore.learningObjectives.filter({$0.goal_Short.lowercased() == currentSubviewLabel!.lowercased()})
                )
            }
        }
        .onAppear {
            filter_Selected = filter_Path
        }.onChange(of: filter_Path) { newValue in
            filter_Selected = filter_Path
        }
        
    }
    
    func sendToDropbox() -> Data?{
        // constants
        let userDefaultsKey = "checkForUploadUserDataDate"
        let twoWeeksInSeconds: Double = 60 * 60 * 24 * 14
        let now = Date()
        
        // getting saved data from user defaults
        var date = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
        if date == nil {
            // First time user open the app => creating date
            date = now
            UserDefaults.standard.set(date, forKey: userDefaultsKey)
            return nil
        }
        
        // Checking if is elapsed one month since last data upload
        let diff = date!.distance(to: now)
        if diff < twoWeeksInSeconds { return nil }
        
        var evaluated_Learning_Objectives : [learning_ObjectiveForJSON] = []
        for LO in learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0}) {
            let temp = learning_ObjectiveForJSON(learningObjective: LO)
            evaluated_Learning_Objectives.append(temp)
        }
        
        var resp : Data?
        do {
            resp =  try JSONEncoder().encode(evaluated_Learning_Objectives)

            return resp
        } catch {
            print("The file could not be loaded")
        }
        
        return nil
    }
    
}

struct MainCompassView_Previews: PreviewProvider {
    static var previews: some View {
        MainCompassView( filter_Path: .constant("None") )
    }
}
