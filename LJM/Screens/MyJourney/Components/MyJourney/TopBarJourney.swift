//
//  TopBarJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct TopBarJourney: View {
    @State var tabs = ["Map", "Challenge"]
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var selectedView : SelectedSegmentView
        
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { i in
                VStack(spacing: 0) {
                    Button(action: {
                        self.selectedView.selectedView = i
                    }, label: {
                        Text(i)
                            .frame(width: 120, height: 40, alignment: .center)
                            .font(.system(size: 24.toFontSize(), weight: .semibold))
                            .foregroundColor(self.selectedView.selectedView == i ? .customBlack : .customDarkGrey)
                            .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
                    }).buttonStyle(PlainButtonStyle())
                    .allowsHitTesting(false)

                    TopBarJourneySelectedBottomView(color: self.selectedView.selectedView == i ? Color.customCyan : .clear)
                }
            }
        }
        .frame(width: 400, height: 50, alignment: .leading)
        .padding(.leading, 20)
        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
    }
}

class SelectedSegmentView: ObservableObject {
    @Published var selectedView: String = "Map"
}

struct TopBarJourneySelectedBottomView: View {
    var color : Color
    var body: some View {
        Capsule()
            .fill(color)
            .frame(width: 120, height: 3)
    }
}
