//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct JourneyMainView: View, LJMView {
    @State var selected = "My Journey"
    @Environment(\.colorScheme) var colorScheme
    @State private var showSearchBarSideBar = true
    
    @StateObject var learningPathsStore = LearningPathStore()
    
    var body: some View {
        ZStack(alignment: .top) {
            if self.selected == "My Journey" {
                MyJourneyView().modifier(PaddingMainSubViews())
                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
            } else if self.selected == "Map" {
                PathsView().modifier(PaddingMainSubViews())
            } else {
                ChallengeView().modifier(PaddingMainSubViews())
            }
            
            HStack {
                TopBarJourney(selected: self.$selected).padding(.top, 20).padding(.leading, 50)
                Spacer()
            }
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
        .environmentObject(learningPathsStore)
        .onAppear {
            Webservices.getAllLearningPaths { learningPathResult, err  in
                print("IJHUGY \(learningPathResult)")
                for learningPath in learningPathResult {
                    learningPathsStore.addItem(learningPath)
                }
            }
        }
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
