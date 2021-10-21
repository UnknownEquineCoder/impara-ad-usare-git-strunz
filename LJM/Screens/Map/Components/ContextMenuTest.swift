//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 18/10/21.
//

import Foundation
import SwiftUI

struct ContextMenuTest: View {
    @State private var isPop = false
    @State private var text = ""
    @State var showSheet = false
    
    var body: some View {
//        Button("test"){ self.isPop.toggle() }
//        .frame(width: 50, height: 50)
//            .contextMenu{
//                Menu("Nested Root") {
//                    Button("Nested #1") {}
//                    Button("Nested #2") {}
//                    Button("Nested #3") {}
//                }
//                Button("Not Nested") { }
//            }
//
//    }
        VStack{
            Button(action: {
                self.isPop.toggle()
                        }) {
                            HStack {
                                Image(systemName: "camera.filters")
//                                                    .renderingMode(.original)
//                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                Text("Filters")
//                                                    .font(.title)
                                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 134.0, height: 35.0)
                        .popover(isPresented: $isPop, arrowEdge: .bottom){
                            VStack {
            //                    Menu("test"){
                                    Menu("View"){
                                        Button("Full Map"){ self.showSheet = false }
                                        Button("Communal"){ self.showSheet = false }
                                        Button("Elective"){ self.showSheet = false }
                                    }.menuStyle(BorderlessButtonMenuStyle())
                                    Menu("Paths"){
                                        Button("Front-end"){ self.showSheet = false }
                                        Button("Back-end"){ self.showSheet = false }
                                        Button("Business"){ self.showSheet = false }
                                        Button("UI/UX"){ self.showSheet = false }
                                        Button("Game"){ self.showSheet = false }
                                    }.menuStyle(BorderlessButtonMenuStyle())
                                    Menu("Strands"){
                                        Button("App Business and Marketing"){ self.showSheet = false }
                                        Button("Process"){ self.showSheet = false }
                                        Button("Professional Skills"){ self.showSheet = false }
                                        Button("Technical"){ self.showSheet = false }
                                        Button("Design"){ self.showSheet = false }
                                    }.menuStyle(BorderlessButtonMenuStyle())
            //                    }
                            }
//            Button("Pop") { self.isPop.toggle() }
//            .popover(isPresented: $isPop, arrowEdge: .bottom) {
//                VStack {
////                    Menu("test"){
//                        Menu("View"){
//                            Button("Full Map"){ self.showSheet = false }
//                            Button("Communal"){ self.showSheet = false }
//                            Button("Elective"){ self.showSheet = false }
//                        }.menuStyle(BorderlessButtonMenuStyle())
//                        Menu("Paths"){
//                            Button("Front-end"){ self.showSheet = false }
//                            Button("Back-end"){ self.showSheet = false }
//                            Button("Business"){ self.showSheet = false }
//                            Button("UI/UX"){ self.showSheet = false }
//                            Button("Game"){ self.showSheet = false }
//                        }.menuStyle(BorderlessButtonMenuStyle())
//                        Menu("Strands"){
//                            Button("App Business and Marketing"){ self.showSheet = false }
//                            Button("Process"){ self.showSheet = false }
//                            Button("Professional Skills"){ self.showSheet = false }
//                            Button("Technical"){ self.showSheet = false }
//                            Button("Design"){ self.showSheet = false }
//                        }.menuStyle(BorderlessButtonMenuStyle())
////                    }
//                }
            }
           
        }

    }
}

struct Sheet: View {
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            Text("Sheet")
            Button("Cancel"){ self.presentation.wrappedValue.dismiss() }
        }
    }
}

struct ContextMenuTest_Previews: PreviewProvider {
    
    static var previews: some View {
        ContextMenuTest()
    }
}

//struct MyButtonStyle: ButtonStyle {
//
//  func makeBody(configuration: Self.Configuration) -> some View {
//    configuration.label
//      .padding()
//      .foregroundColor(.white)
//      .background(configuration.isPressed ? Color.customCyan : Color(red: 97/255, green: 95/255, blue: 95/255))
//      .cornerRadius(7.0)
//  }
//
//}
