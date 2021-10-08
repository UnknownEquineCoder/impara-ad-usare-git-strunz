//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct JourneyMainView: View, LJMView {
    @State var selected = "Map"
    @Environment(\.colorScheme) var colorScheme
    @State private var showSearchBarSideBar = true
    @State private var alertIsShowing = false
        
    @ObservedObject var selectedView = SelectedSegmentView()
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
//    @StateObject var mapLearningObjectivesStore = MapLearningObjectivesStore()
//    @StateObject var challengesStore = ChallengesStore()
//    @StateObject var studentLearningObjectivesStore = StudentLearningObjectivesStore()
//    @EnvironmentObject var strandsStore: StrandsStore
//    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.selectedView.selectedView == "Map" {
                PathsView(totalLOs: self.totalLOs, selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
                
            } else {
                ChallengeView(totalLOs: self.totalLOs, selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
            }
            HStack {
                TopBarJourney(selectedView: self.selectedView).padding(.top, 20).padding(.leading, 50)
                Spacer()
            }
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
        .alert(isPresented: $alertIsShowing) {
            Alert(title: Text("Error"),
                  message: Text("No VPN detected, connect to the VPN and log in again."),
                  dismissButton: .default(Text("OK")) {
                    
                  })
        }
//        .onAppear {
//            Webservices.getAllLearningPaths { learningPathResult, err  in
//                if err == nil && learningPathResult != nil {
//                    for learningPath in learningPathResult! {
//                        if !LJM.storage.challenges.contains(learningPath) {
//                            if learningPath.title!.lowercased().contains("challenge") {
//                                // challengesStore.addItem(learningPath)
//                                LJM.storage.challenges.append(learningPath)
//                            } else {
//                                //    learningPathsStore.addItem(learningPath)
//                                LJM.storage.learningPaths.append(learningPath)
//                            }
//                        }
//                    }
//                } else {
//                    self.alertIsShowing = true
//                }
//
//                Webservices.getStudentJourneyLearningObjectives { (learningObjectives, err) in
//                    if err == nil {
//                        for learningObjective in learningObjectives {
//                            if !LJM.storage.studentLearningObjectives.contains(learningObjective) {
//                                LJM.storage.studentLearningObjectives.append(learningObjective)
//                            }
//                        }
//                    }
//                }
//
//                Webservices.getAllLearningObjectives { (learningObjectives, err) in
//                    if err == nil {
//                        for learningObjective in learningObjectives {
//                            if !LJM.storage.mapLearningObjectives.contains(learningObjective) {
//                                LJM.storage.mapLearningObjectives.append(learningObjective)
//                                if learningObjective.strand != nil {
////                                    if !strandsStore.strands.contains(learningObjective.strand!.strand) {
////                                        strandsStore.addItem(learningObjective.strand!.strand)
////                                    }
//                                    if !LJM.storage.strands.contains(learningObjective.strand!) {
//                                        LJM.storage.strands.append(learningObjective.strand!)
//                                    }
//                                }
//                            }
//                        }
//                    } else {
//                        self.alertIsShowing = true
//                    }
//                }
//            }
//        }
//        .environmentObject(mapLearningObjectivesStore)
//        .environmentObject(challengesStore)
//        .environmentObject(studentLearningObjectivesStore)
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
