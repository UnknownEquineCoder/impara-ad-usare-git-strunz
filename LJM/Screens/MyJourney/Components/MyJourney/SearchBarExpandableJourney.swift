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
    
    var body: some View {
        
        HStack {
//            Image(systemName: "magnifyingglass")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 18, height: 18, alignment: .center)
//                .foregroundColor(Color.customBlack)
//                .background(Color.clear)
            
            VStack {
                ZStack {
                    
                    TextField("Search", text: $txtSearchBar)
                        .foregroundColor(Color.customBlack)
                        .textFieldStyle(RoundedBorderTextFieldStyle.init())
                    
                    Button(action: {
                        withAnimation {
                            self.txtSearchBar = ""
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(Color(red: 160/255, green: 159/255, blue: 159/255))
                            .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
//                            .foregroundColor(.customBlack)
                            .background(Color.clear)
                    }).buttonStyle(PlainButtonStyle())
                    .background(Color.clear)
                    .padding(.leading, 265)
                }
            }
            
            
        }
        
        .padding([.trailing, .leading], 6)
        .frame(width:300)
//        .overlay(RoundedRectangle(cornerRadius: 17).stroke(lineWidth: 1).padding(5).foregroundColor(Color.customCyan).frame(width: 310, height: 40))
    }
    
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney(txtSearchBar: .constant("rrr"))
    }
}
