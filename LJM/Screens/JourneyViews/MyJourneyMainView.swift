//
//  MyJourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 20/04/2021.
//

import SwiftUI

struct MyJourneyMainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showSearchBarSideBar = true
    
    @Binding var selectedMenu: OutlineMenu
    
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
 //   @StateObject var studentLearningObjectivesStore = StudentLearningObjectivesStore()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MyJourneyView(selectedMenu: $selectedMenu, totalLOs: self.totalLOs).modifier(PaddingMainSubViews())
            
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
//        .onAppear {
//            Webservices.getStudentJourneyLearningObjectives { (learningObjectives, err) in
//                if err == nil {
//                    for learningObjective in learningObjectives {
////                        studentLearningObjectivesStore.addItem(learningObjective)
//                        LJM.storage.studentLearningObjectives.append(learningObjective)
//                    }
//                }
//            }
//            
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
//
//                }
//            }
//        }
      //  .environmentObject(studentLearningObjectivesStore)
    }
}

struct MyJourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyMainView(selectedMenu: .constant(.journey))
    }
}
