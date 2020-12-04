////
////  DropDownFilterMenu.swift
////  LJM
////
////  Created by Laura Benetti on 03/12/20.
////
//
//import Foundation
//import SwiftUI
//
//
//struct DropDownFilterMenu: View {
//    @State var expand = false
//    @State var dictPaths = [String: Color]()
//    @Binding var selectedPath : String
//    @State var colorSelectedPath = Color.gray
//    
//    var body: some View {
//        let keys = dictPaths.map{$0.key}
//        let values = dictPaths.map{$0.value}
//        
//        VStack {
//            HStack {
//                Text(self.selectedPath)
//                    .frame(width: 150, height: 30, alignment: .center)
//                    .foregroundColor(colorSelectedPath)
//                    .font(.system(size: 15, weight: .semibold, design: .rounded))
//                    .padding(.leading, 10)
//                    .background(Color.white)
//                Image(systemName: expand ? "chevron.up.circle" : "chevron.down.circle")
//                    .resizable()
//                    .frame(width: 18, height: 18)
//                    .foregroundColor(Color("customCyan"))
//                
//            }.onTapGesture {
//                self.selectedPath = "Select your path"
//                self.colorSelectedPath = Color.gray
//                self.expand.toggle()
//            }
//            
//            if expand {
//                ForEach(keys.indices, id: \.self) { i in
//                    VStack {
//                        Button(action: {
//                            self.selectedPath = keys[i]
//                            self.colorSelectedPath = values[i]
//                            self.expand.toggle()
//                        }) {
//                            Text(keys[i])
//                                .font(.system(size: 15, weight: .semibold, design: .rounded))
//                                .foregroundColor(self.selectedPath == keys[i] ? .black : .gray)
//                                .frame(width: 150, height: 30)
//                                .background(Color.white)
//                        }.buttonStyle(PlainButtonStyle())
//                    }
//                }
//            }
//        }
//        .frame(height: expand ? 175 : 30, alignment: .top)
//        .padding(5)
//        .cornerRadius(20)
//        .animation(.spring())
//        .background(Color.white)
//        .border(expand ? Color.black : Color.white)
//    }
//}
//
//
//
//
//
//
//
//
//struct DropDownFilterMenu_Previews: PreviewProvider {
//    @State var selectedPath = "Select your path"
//    var paths = ["Design" : Color("customCyan"), "Frontend": Color.orange, "Backend": Color.yellow, "Business": Color.purple]
//    static var previews: some View {
//        DropDownFilterMenu(dictPaths: self.paths, selectedPath: $selectedPath)
//    }
//}
//
//
//
