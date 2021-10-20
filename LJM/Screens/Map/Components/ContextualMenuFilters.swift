//
//  ContextualMenuFilters.swift
//  LJM
//
//  Created by Laura Benetti on 06/10/21.
//

import Foundation
import SwiftUI

struct ContextMenuView: View {
    @State var showPopup1 = false
    @State var showSheet2 = false
    
    var body: some View {
        
        //        Menu("Editing"){
        //            Button(action: {
        //                          // copy the content to the paste board
        //                        }) {
        //                            Text("Copy")
        //                            Image(systemName: "chevron.right")
        //                        }
        //        }.menuStyle(BorderlessButtonMenuStyle())
        
        //        Menu("Editing") {
        //            VStack{
        //            Button("Set In Point", action: setInPoint)
        //            HStack{
        //                Image(systemName: "chevron.right")
        //                    .resizable()
        //                    .foregroundColor(Color("customCyan"))
        //                    .frame(width: 20, height: 20, alignment: .center)
        //            }
        //            }
        //        }
        //        .menuStyle(BorderlessButtonMenuStyle())
        //        MenuButton("Filters") {
        //            Button(action: {
        //              print("Clicked an item")
        //            }) {
        //                Text("Menu Item Text")
        //            }
        //        }.menuButtonStyle(BorderlessButtonMenuButtonStyle())
        
        VStack {
            Text("popover 1")
                .onTapGesture { self.showPopup1 = true}
                .popover(isPresented: $showPopup1, arrowEdge: .trailing )
            { Popover1(showSheet: self.$showPopup1) }
            .background(Color.red)
   
        }
        
        
        
    }
    struct Popover1: View {
        @Binding var showSheet: Bool
        
        var body: some View {
            VStack {
                Menu("Editing"){
                    Menu("View"){
                        Button("Full Map"){ self.showSheet = false }
                        Button("Communal"){ self.showSheet = false }
                        Button("Elective"){ self.showSheet = false }
                    }
                    Menu("Paths"){
                        Button("Front-end"){ self.showSheet = false }
                        Button("Back-end"){ self.showSheet = false }
                        Button("Business"){ self.showSheet = false }
                        Button("UI/UX"){ self.showSheet = false }
                        Button("Game"){ self.showSheet = false }
                    }
                    Menu("Strands"){
                        Button("App Business and Marketing"){ self.showSheet = false }
                        Button("Process"){ self.showSheet = false }
                        Button("Professional Skills"){ self.showSheet = false }
                        Button("Technical"){ self.showSheet = false }
                        Button("Design"){ self.showSheet = false }
                    }
                }.menuStyle(BorderlessButtonMenuStyle())
                
                
                //          Text("Poppver 1 \(self.showSheet ? "T" : "F")")
                //          Button("Cancel"){ self.showSheet = false }
            }
        }
    }
    
    
    
    struct Sheet2: View {
        @Environment(\.presentationMode) var presentation
        
        var body: some View {
            VStack {
                Text("Sheet 2")
                Button("Cancel"){ self.presentation.wrappedValue.dismiss() }
            }
        }
    }
    
    
    //    func setInPoint(){
    //        print("Laura")
    //        Menu("Editing") {
    //        }
    //        .menuStyle(BorderlessButtonMenuStyle())
    //    }
    
    struct ContextMenuView_Previews: PreviewProvider {
        
        static var previews: some View {
            ContextMenuView()
        }
    }
}
