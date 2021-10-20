//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 18/10/21.
//

import Foundation
import SwiftUI

struct MenuTest: View {
    @State private var isPop = false
    @State private var text = ""
    @Binding var showView: Bool
    
    
    var body: some View {
        Text("test")
//            .foregroundColor(color)
            .font(.system(size: 20.toFontSize()))
            .fontWeight(.light)
            .underline()
            .frame(width: 50, height: 50)
            .onTapGesture {
//                self.targetLabel = skill
                self.showView = true
                ContextMenu2()
            }
    }
        
        
    }

struct ContextMenu2: View {
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
            }
        }

struct MenuTest_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuTest()
    }
}
