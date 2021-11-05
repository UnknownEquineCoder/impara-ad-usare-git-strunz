//
//  CompassPopover.swift
//  LJM
//
//  Created by Laura Benetti on 18/02/21.
//

import Foundation
import SwiftUI

struct CompassPopover: View {
    
    @State private var showPopover: Bool = false

    

    var body: some View {
        VStack {
            Button(action: {
                self.showPopover =  true
            }) {
                HStack{
                    Text("Test")
                        .padding()
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(Color("customCyan"))
                    
                }.frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
            }
            .popover(
                isPresented: self.$showPopover,
                arrowEdge: .bottom
                
            ) {
                VStack{
                PopoverView().frame(width: 200, height: 200)
            }
            .padding(.trailing, 20)
            
        }
        
    }
    }
    
}

struct PopoverView: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack {
            Text("Adding this LO will automatically add it to 'Journey' and mark it as checked in 'Map'").multilineTextAlignment(.leading).lineLimit(6)
            HStack{
            Button("Cancel") {
            }
                Button("Got it!") {
                }
            }.padding()
            HStack{
                Button {
                    isSelected.toggle()
                } label: {
                    Image(systemName: isSelected ? "checkmark.square.fill" : "square")                }.buttonStyle(PlainButtonStyle())
                Text("Don't tell me anymore")
            }
        }.padding()
    }
}
    

struct CompassPopover_Previews: PreviewProvider {
    static var previews: some View {
      CompassPopover()
    }
}
