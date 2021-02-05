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
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.selected == "My Journey" {
                MyJourneyView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 280)
                    .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255): .white)
            } else if self.selected == "Map" {
                PathsView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 280)
            } else {
                ChallengeView().padding(.top, 80).padding([.top, .leading, .trailing], 20).padding(.trailing, showSearchBarSideBar ? 0 : 280)
            }
            
            HStack {
                TopBarJourney(selected: self.$selected).padding(.top, 20).padding(.leading, 50)
                
                Spacer()
                
                SearchBarExpandableJourney(showSearchBarSideBar: self.$showSearchBarSideBar).background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
                    .padding(.trailing, 20).overlay(SearchBarSideBar(showSearchBarSideBar: self.$showSearchBarSideBar).padding(.top, 1050))
            }
            
        }.background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
