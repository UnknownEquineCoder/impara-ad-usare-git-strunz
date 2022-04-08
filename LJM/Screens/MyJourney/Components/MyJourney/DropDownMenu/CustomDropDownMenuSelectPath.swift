//
//  CustomDropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownSelectPathView: View {
    @State var expand = false
    var paths : [learning_Path?]
    @Binding var selectedPath : String
    @State var selectedPath2 : String?
    @State var colorSelectedPath = Color.gray
    @State var colorSelectedPath2 : Color?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            HStack {
                Text(self.selectedPath)
                    .frame(width: 150, height: 30, alignment: .center)
                    .foregroundColor(colorSelectedPath)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.leading, 10)
                    .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
                Image(systemName: expand ? "chevron.up.circle" : "chevron.down.circle")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color.defaultColor)
                
            }.onTapGesture {
                self.selectedPath = "None"
                self.colorSelectedPath = Color.gray
                self.expand.toggle()
            }
            
        }
        .frame(height: expand ? 175 : 30, alignment: .top)
        .padding(5)
        .cornerRadius(20)
        .animation(.spring())
        .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
    }
}
 
