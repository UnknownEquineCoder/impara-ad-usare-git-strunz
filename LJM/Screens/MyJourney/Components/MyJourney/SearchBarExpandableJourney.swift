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
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18, alignment: .center)
                .foregroundColor(Color.customBlack)
                .background(Color.clear)
            
            VStack {
                ZStack {
                    
                    TextField("Search", text: $txtSearchBar)
                        .foregroundColor(Color.customBlack)
                        .textFieldStyle(RoundedBorderTextFieldStyle.init())
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.customDarkGrey)
                        .opacity(0.5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.top, 30)
                }
            }
            
            Button(action: {
                withAnimation {
                    self.txtSearchBar = ""
                }
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.customBlack)
                    .background(Color.clear)
            }).buttonStyle(PlainButtonStyle())
            .background(Color.clear)
        }
        
        .padding([.trailing, .leading], 6)
        .frame(width:300)
        .overlay(RoundedRectangle(cornerRadius: 17).stroke(lineWidth: 1).padding(5).foregroundColor(Color.customCyan).frame(width: 310, height: 40))
    }
    
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney(txtSearchBar: .constant("rrr"))
    }
}
