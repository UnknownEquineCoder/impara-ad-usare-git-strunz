//
//  ContentView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var studentLearningObjectivesStore = StudentLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var mapLearningObjectivesStore = MapLearningObjectivesStore()
    @StateObject var strandsStore = StrandsStore()

    var body: some View {
        
        Sidebar().onAppear {
            Webservices.getAllLearningPaths { learningPathResult, err  in
                for learningPath in learningPathResult {
                    learningPathsStore.addItem(learningPath)
                }
                
                Webservices.getStudentJourneyLearningObjectives { (learningObjectives, err) in
                    for learningObjective in learningObjectives {
                        studentLearningObjectivesStore.addItem(learningObjective)
                    }
                }
                
                Webservices.getAllLearningObjectives { (learningObjectives, err) in
                    for learningObjective in learningObjectives {
                        mapLearningObjectivesStore.addItem(learningObjective)
                        if learningObjective.strand != nil {
                            if !strandsStore.strands.contains(learningObjective.strand!) {
                                strandsStore.addItem(learningObjective.strand!)
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(studentLearningObjectivesStore)
        .environmentObject(learningPathsStore)
        .environmentObject(mapLearningObjectivesStore)
        .environmentObject(strandsStore)
//        LoginView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
