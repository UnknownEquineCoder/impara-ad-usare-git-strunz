//
//  JourneyMainView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct MapMainView: View {
    @Environment(\.colorScheme) var colorScheme
        
    @ObservedObject var selectedView = SelectedSegmentView()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if self.selectedView.selectedView == "Map" {
                MapView(selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
            } else {
                EmptyView()
//                ChallengeView( selectedSegmentView: self.selectedView).modifier(PaddingMainSubViews())
            }
            
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color(red: 245/255, green: 245/255, blue: 245/255) )
    }
}
