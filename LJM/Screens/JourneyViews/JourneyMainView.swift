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
    
    @ObservedObject var selectedView = SelectedSegmentView()
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            if self.selectedView.selectedView == "My Journey" {
                MyJourneyView(selectedView: self.selectedView).modifier(PaddingMainSubViews())
                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
            } else if self.selectedView.selectedView == "Map" {
                PathsView().modifier(PaddingMainSubViews())
            } else {
                ChallengeView().modifier(PaddingMainSubViews())
            }
            
            HStack {
                TopBarJourney(selectedView: self.selectedView).padding(.top, 20).padding(.leading, 50)
                Spacer()
            }
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
        
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
