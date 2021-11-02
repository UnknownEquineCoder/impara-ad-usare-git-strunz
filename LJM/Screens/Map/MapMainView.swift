//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct MapMainView: View {
    @State var selected = "Map"
    @Environment(\.colorScheme) var colorScheme
    @State private var showSearchBarSideBar = true
    @State private var alertIsShowing = false
        
    @ObservedObject var selectedView = SelectedSegmentView()
    
    // new data flow stuff
        
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.selectedView.selectedView == "Map" {
                MapView(selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
                
            } else {
                ChallengeView( selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
            }
//            HStack {
//                TopBarJourney(selectedView: self.selectedView).padding(.top, 20).padding(.leading, 50)
//                Spacer()
//            }
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color(red: 245/255, green: 245/255, blue: 245/255) )
    }
}

//struct JourneyMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapMainView()
//    }
//}
