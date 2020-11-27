//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct JourneyMainView: View {
    @State var selected = "My Journey"
    
    var body: some View {
        VStack(spacing: 22) {
            HStack {
                TopBarJourney(selected: self.$selected)
                
                Spacer()
                
                SearchBarExpandableJourney().background(Color.white)
            }
            
            if self.selected == "My Journey" {
                MyJourneyView().frame(width: 1000, height: 600)
                    .background(Color.white)
            } else if self.selected == "Paths" {
                PathsView()
            } else {
                ChallengeView()
            }
        }
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
