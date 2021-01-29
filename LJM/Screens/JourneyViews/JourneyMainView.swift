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
    
    @State private var showSearchBarSideBar = true
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.selected == "My Journey" {
                MyJourneyView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 320)
                    .background(Color.white)
            } else if self.selected == "Map" {
                PathsView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 320)
            } else {
                ChallengeView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 320)
            }
            
            HStack {
                TopBarJourney(selected: self.$selected).padding(.top, 20).padding(.leading, 50)
                
                Spacer()
                
                SearchBarExpandableJourney(showSearchBarSideBar: self.$showSearchBarSideBar).background(Color.white).padding(.trailing, 20).overlay(SearchBarSideBar(showSearchBarSideBar: self.$showSearchBarSideBar).padding(.top, 1050))
            }
            
        }.background(Color.white)
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
