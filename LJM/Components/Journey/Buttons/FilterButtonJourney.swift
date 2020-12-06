//
//  FilterButtonJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct FilterButtonJourney : View {
    
    @State var expand = false
    let arrayFiltersButton = ["All", "Core", "Elective", "Evaluated"]
    
    @Binding var selectedFilter : String
    @State var selectedFilter2 : String?
    
    var body: some View {
        
        Button(action: {
            self.expand.toggle()
        }) {
            VStack {
                HStack {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .foregroundColor(Color.customCyan)
                        .frame(width: 10, height: 5, alignment: .center)
                        .padding(.leading, 10)
                    Text("Filters")
                        .padding()
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(Color.customCyan)
                        .frame(width: 130, height: 30, alignment: .center)
                        .background(Color.white)
                }.frame(width: 130, height: 30, alignment: .leading)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
                
                if expand {
                    ForEach(arrayFiltersButton, id: \.self) { i in
                        VStack {
                            Button(action: {
                                self.selectedFilter = i
                                self.selectedFilter2 = i
                                self.expand.toggle()
                            }) {
                                HStack {
                                    Text(i)
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.gray)
                                        .frame(width: 150, height: 30)
                                        .offset(x: 12)
                                }
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }.frame(height: expand ? 175 : 30, alignment: .top)
            .padding(5)
            .cornerRadius(20)
            .animation(.spring())
            .background(Color.white)
            .border(expand ? Color.customBlack : Color.white)
        }
        

    }
}
