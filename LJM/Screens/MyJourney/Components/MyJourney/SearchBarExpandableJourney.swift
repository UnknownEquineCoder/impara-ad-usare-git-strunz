//
//  SearchBarExpandableJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct SearchBarExpandableJourney: View {
    
    @Binding var txtSearchBar : String
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isUpdated : Bool
        
    var body: some View {
        
        HStack {
            TextField("Search", text: $txtSearchBar)
                .foregroundColor(Color.customBlack)
                .textFieldStyle(PlainTextFieldStyle.init())
                .padding(.leading, 5)
                .onChange(of: txtSearchBar) { _ in
                    isUpdated.toggle()
                }
                        
            Button(action: {
                withAnimation {
                    self.txtSearchBar = ""
                }
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .cursor(.pointingHand)
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
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
        SearchBarExpandableJourney(txtSearchBar: .constant("rrr"), isUpdated: .constant(true))
    }
}
