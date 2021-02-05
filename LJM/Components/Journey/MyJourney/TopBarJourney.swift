//
//  TopBarJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct TopBarJourney: View {
    @State var tabs = ["My Journey", "Map", "Challenge"]
    @Binding var selected : String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            
            ForEach(tabs, id: \.self) { i in
                VStack(spacing: 0) {
                    Button(action: {
                        self.selected = i
                    }, label: {
                        Text(i)
                            .frame(width: 100, height: 40, alignment: .center)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(self.selected == i ? .customBlack : .customDarkGrey)
                            .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255): .white)
                    }).buttonStyle(PlainButtonStyle())
                    
                    TopBarJourneySelectedBottomView(color: self.selected == i ? Color.customCyan : .clear)
                }
            }
        }
        .frame(width: 400, height: 50, alignment: .leading)
        .padding(.leading, 20)
        .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255): .white)
    }
}

struct TopBarJourneySelectedBottomView: View {
    var color : Color
    var body: some View {
        Capsule()
            .fill(color)
            .frame(width: 100, height: 3)
    }
}

struct TopBarJourney_Previews: PreviewProvider {
    static var previews: some View {
        TopBarJourney(selected: .constant("My Journey"))
    }
}
