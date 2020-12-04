//
//  SearchBarExpandableJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct SearchBarExpandableJourney: View {
    
    @State var show = false
    @Binding var showSearchBarSideBar: Bool
    @State var txt = ""
    
    var body: some View {
        
        HStack {
            if self.show {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17, alignment: .center)
                    .foregroundColor(Color.customBlack)
                    .background(Color.clear)
                
                VStack {
                    ZStack {
                        if txt.isEmpty {
                            Text("Search")
                                .foregroundColor(.customDarkGrey)
                                .padding(.trailing, 60)
                                .opacity(0.5)
                        }
                        
                        TextField("Search", text: self.$txt)
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
                        self.showSearchBarSideBar.toggle()
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
                        self.showSearchBarSideBar.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15, alignment: .center)
                        .foregroundColor(Color.customBlack)
                        .background(Color.clear)
                        .padding(5)
                }).buttonStyle(PlainButtonStyle())
                .background(Color.clear)
            }
        }
        .padding(self.show ? 6 : 0)
        .frame(width: self.show ? 300 : 25)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).foregroundColor(Color.customCyan))
    }
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney(showSearchBarSideBar: .constant(true))
    }
}
