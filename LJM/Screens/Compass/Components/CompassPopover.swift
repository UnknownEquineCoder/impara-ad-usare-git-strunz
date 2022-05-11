//
//  CompassPopover.swift
//  LJM
//
//  Created by Laura Benetti on 18/02/21.
//

import Foundation
import SwiftUI

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
