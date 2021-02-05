//
//  SearchBarExpandableJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct SearchBarExpandableJourney: View {
    
    @State var show = false
    @State var txtSearchBar = ""
    
    var body: some View {
        
        HStack {
            if self.show {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18, alignment: .center)
                    .foregroundColor(Color.customBlack)
                    .background(Color.clear)
                
                VStack {
                    ZStack {
                        if txtSearchBar.isEmpty {
                            Text("Search")
                                .foregroundColor(.customDarkGrey)
                                .padding(.trailing, 60)
                                .opacity(0.5)
                        }
                        
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
                        self.show.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.customBlack)
                        .background(Color.clear)
                }).buttonStyle(PlainButtonStyle())
                .background(Color.clear)
                
            } else {
                Button(action: {
                    withAnimation {
                        self.show.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(Color.customBlack)
                        .background(Color.clear)
                        .padding(5)
                }).buttonStyle(PlainButtonStyle())
                .background(Color.clear)
            }
        }
        .padding([.trailing, .leading], self.show ? 6 : 0)
        .frame(width: self.show ? 300 : 34)
        .overlay(RoundedRectangle(cornerRadius: 17).stroke(lineWidth: 1).padding(5).foregroundColor(Color.customCyan).frame(width: self.show ? 310 : 40, height: 40))

    }
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney()
    }
}
