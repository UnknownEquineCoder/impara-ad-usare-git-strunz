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
        ZStack(alignment: .top) {
            
            if self.selected == "My Journey" {
                MyJourneyView().padding(.top, 80).padding([.top, .leading, .trailing], 20)
                    .background(Color.white)
            } else if self.selected == "Map" {
                PathsView().padding(.top, 80).padding([.top, .leading, .trailing], 20)
            } else {
                ChallengeView().padding(.top, 80).padding([.top, .leading, .trailing], 20)
            }
            
            HStack {
                TopBarJourney(selected: self.$selected).padding(.top, 20).padding(.leading, 50)
                
                Spacer()
                
            }
            
        }.background(Color.white)
    }
}

struct JourneyMainView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyMainView()
    }
}
