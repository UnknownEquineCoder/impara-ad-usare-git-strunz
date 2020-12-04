//
//  FilterButtonJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct FilterButtonJourney : View {
    
    var body: some View {
        
        Button(action: {
            
        }) {
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
        }
    }
}
