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
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                TopBarJourney(selected: self.$selected).padding(.top, 20)
                
                Spacer()
                
                SearchBarExpandableJourney().background(Color.white).padding(.trailing, 20)
            }
            
            if self.selected == "My Journey" {
                MyJourneyView().padding(20)
                    .background(Color.white)
            } else if self.selected == "Paths" {
                PathsView().padding(20)
            } else {
                ChallengeView()
            }
        }.background(Color.white)
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
