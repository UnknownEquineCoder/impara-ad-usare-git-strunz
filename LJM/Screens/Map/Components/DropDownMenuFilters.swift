//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 03/12/20.
//

import Foundation
import SwiftUI


struct DropDownMenuFilters: View {
    @State var expand = false
    @State private var showPopover: Bool = false
    @State var firstButtonSelected: Bool = false
    @State var selectedRows = Set<UUID>()
    
    @Binding var selectedStrands : [String]
    
    @Environment(\.colorScheme) var colorScheme
    
    var filterOptions = [FilterChoice(descriptor: "Design"),
                         FilterChoice(descriptor: "Business/Marketing"),
                         FilterChoice(descriptor: "Professional Skills"),
                         FilterChoice(descriptor: "Technical"),
                         FilterChoice(descriptor: "Process")
    ]
    
    var body: some View {
            Menu {
                Button("Cancel", action: {})
                Menu("More") {
                    Button("Rename", action: {})
                    Button("Developer Mode", action: {})
                }
                Button("Search", action: {})
                Button("Add", action: {})
            } label: {
                HStack(spacing: 13) {
                    Image("Filters_Icon")
                        .resizable()
                        .foregroundColor(Color("customCyan"))
                        .frame(width: 10, height: 10, alignment: .center)
                    Text("Filters")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(Color("customCyan"))
                }
            }
            .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
            .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
            .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: false))
    }
}


struct DropDownMenuSort: View {
    @State var expand = false
    @State private var showPopover: Bool = false
    @State var firstButtonSelected: Bool = false
    @State var selectedRows = Set<UUID>()
    
    @State var selectedSort: String? = nil
    
    @Environment(\.colorScheme) var colorScheme
    
    var filterOptions = [FilterChoice(descriptor: "By strand alphabetically"),
                         FilterChoice(descriptor: "Most evaluated first"),
                         FilterChoice(descriptor: "Least evaluated first"),
                         FilterChoice(descriptor: "By date")
    ]
    
    var body: some View {
        VStack {
            Button(action: {
                self.showPopover =  true
            }) {
                HStack(spacing: 13) {
                    Image("Sort_Icon")
                        .resizable()
                        .foregroundColor(Color("customCyan"))
                        .frame(width: 20, height: 20, alignment: .center)
                    Text("Sort")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(Color("customCyan"))
                    
                }.frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
                    .background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
            }
            .popover(
                isPresented: self.$showPopover,
                arrowEdge: .bottom
                
            ) {
                VStack{
                    List(filterOptions, id: \.self){
                        element in
                        SingleSelectRow(selectedSort: $selectedSort, model: element, selectedItems: $selectedRows)
                    }
                }.frame(width: 200, height: 150)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 20)
            
        }
        
    }
    
}

