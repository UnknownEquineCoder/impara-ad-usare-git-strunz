//
//  SearchBarExpandableJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct SearchBarExpandableJourney: View {
    
    @Binding var txtSearchBar : String
        
    var body: some View {
        
        HStack {
            TextField("Search", text: $txtSearchBar)
                .foregroundColor(Color.customBlack)
                .textFieldStyle(PlainTextFieldStyle.init())
                .padding(.leading, 5)
                        
            Button(action: {
                withAnimation {
                    self.txtSearchBar = ""
                }
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .cursor(.pointingHand)
                    .foregroundColor(Color.gray160)
            }).buttonStyle(PlainButtonStyle())
                .zIndex(1)
        }
        .frame(width:300)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.customDarkGrey, lineWidth: 1)
                .padding(-5)
        )
        .padding([.trailing, .leading], 6)
    }
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney(txtSearchBar: .constant("rrr"))
    }
}
