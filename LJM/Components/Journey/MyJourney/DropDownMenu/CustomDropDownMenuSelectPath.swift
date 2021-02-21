//
//  CustomDropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownSelectPathView: View {
    @State var expand = false
    var paths : [LearningPath?]
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
                    .foregroundColor(Color.customCyan)
                
            }.onTapGesture {
                self.selectedPath = "Select your path"
                self.colorSelectedPath = Color.gray
                self.expand.toggle()
            }
            
//            if expand {
//                ForEach(paths, id: \.self) { i in
//                    VStack {
//                        Button(action: {
//                            self.expand.toggle()
//                        }) {
//                            HStack {
//                                Text(i?.title ?? "error")
//                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
//                                    .frame(width: 150, height: 30)
//                                    .offset(x: selectedPath2 == nil ? 12 : 0)
//
//                                Button(action: {
//                                    self.selectedPath = "Select your path"
//                                    self.selectedPath2 = nil
//                                    self.colorSelectedPath2 = nil
//                                    self.expand.toggle()
//                                }) {
//                                    Image(systemName: "xmark.circle.fill")
//                                }.buttonStyle(PlainButtonStyle())
//                                .foregroundColor(Color.black)
//                            }
//                        }.buttonStyle(PlainButtonStyle())
//                    }
//                }
//            }
        }
        .frame(height: expand ? 175 : 30, alignment: .top)
        .padding(5)
        .cornerRadius(20)
        .animation(.spring())
        .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
        //        .border(expand ? Color.customBlack : Color.white)
    }
}


// IMPLEMENTATION

//DropDownSelectPathView(paths: self.learningPaths, selectedPath: $selectedPath)
//    .frame(maxWidth: .infinity, alignment: .leading)
//    .padding(.leading, 230)
//    .padding(.top, 10)
//    .zIndex(1)
