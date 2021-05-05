//
//  MyJourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 20/04/2021.
//

import SwiftUI

struct MyJourneyMainView: View, LJMView {
    @Environment(\.colorScheme) var colorScheme
    @State private var showSearchBarSideBar = true
    
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    @StateObject var studentLearningObjectivesStore = StudentLearningObjectivesStore()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MyJourneyView(totalLOs: self.totalLOs).modifier(PaddingMainSubViews())
            
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
        .onAppear {
            Webservices.getStudentJourneyLearningObjectives { (learningObjectives, err) in
                if err == nil {
                    for learningObjective in learningObjectives {
                        studentLearningObjectivesStore.addItem(learningObjective)
                    }
                }
            }
        }
        .environmentObject(studentLearningObjectivesStore)
    }
}

struct MyJourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyMainView()
    }
}
