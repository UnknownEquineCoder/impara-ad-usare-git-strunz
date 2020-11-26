//
//  TopBarJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import Foundation
import SwiftUI

struct TopBarJourney: View {
    @State var tabs = ["My Journey", "Paths", "Challenge"]
    @Binding var selected : String
    
    var body: some View {
        HStack {
            
            ForEach(tabs, id: \.self) { i in
                VStack {
                    Button(action: {
                        self.selected = i
                    }, label: {
                        Text(i)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(self.selected == i ? .black : .gray)
                    }).buttonStyle(PlainButtonStyle())
                    TopBarJourneySelectedBottomView(color: self.selected == i ? Color("customCyan") : .clear)
                }
            }
        }
        .frame(width: 400, height: 50)
        .background(Color.white)
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
