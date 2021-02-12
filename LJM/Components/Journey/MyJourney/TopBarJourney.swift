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
                            .frame(width: 120, height: 40, alignment: .center)
                            .font(.system(size: 24.toFontSize(), weight: .semibold))
                            .foregroundColor(self.selected == i ? .customBlack : .customDarkGrey)
                            .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
                    }).buttonStyle(PlainButtonStyle())
                    
                    TopBarJourneySelectedBottomView(color: self.selected == i ? Color.customCyan : .clear)
                }
            }
        }
        .frame(width: 400, height: 50, alignment: .leading)
        .padding(.leading, 20)
        .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255): .white)
    }
}

struct TopBarJourneySelectedBottomView: View {
    var color : Color
    var body: some View {
        Capsule()
            .fill(color)
            .frame(width: 120, height: 3)
    }
}

struct TopBarJourney_Previews: PreviewProvider {
    static var previews: some View {
        TopBarJourney(selected: .constant("My Journey"))
    }
}
