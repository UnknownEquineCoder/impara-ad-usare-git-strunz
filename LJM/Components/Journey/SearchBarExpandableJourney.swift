//
//  SearchBarExpandableJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct SearchBarExpandableJourney: View {
    
    @State var show = false
    @State var txt = ""
    
    var body: some View {
        
        HStack {
            if self.show {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.black)
                    .background(Color.clear)
                    .frame(width: 17, height: 17, alignment: .center)
                
                VStack {
                    ZStack {
                        if txt.isEmpty {
                            Text("Search")
                                .foregroundColor(.gray)
                                .padding(.trailing, 60)
                                .opacity(0.5)
                        }
                        
                        TextField("Search", text: self.$txt)
                            .foregroundColor(Color.black)
                            .textFieldStyle(RoundedBorderTextFieldStyle.init())
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
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
                        .foregroundColor(.black)
                        .background(Color.clear)
                }).buttonStyle(PlainButtonStyle())
                .background(Color.clear)
                
            } else {
                Button(action: {
                    withAnimation {
                        self.show.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .background(Color.clear)
                        .frame(width: 20, height: 20, alignment: .center)
                }).buttonStyle(PlainButtonStyle())
                .background(Color.clear)
                
            }
        }
        .padding(self.show ? 6 : 0)
        .border(self.show ? Color("customCyan") : Color.clear, width: 1)
        .cornerRadius(20)
    }
}


struct SearchBarExpandableJourney_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarExpandableJourney()
    }
}
