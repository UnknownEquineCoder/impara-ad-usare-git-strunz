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
    
    var filterOptions = [FilterChoice(descriptor: "Design"),
                         FilterChoice(descriptor: "Business/Marketing"),
                         FilterChoice(descriptor: "Professional Skills"),
                         FilterChoice(descriptor: "Technical"),
                         FilterChoice(descriptor: "Process")
    ]
    
    var body: some View {
        VStack {
            Button(action: {
                self.showPopover =  true
            }) {
                HStack{
//                    Image(systemName: "chevron.down")
//                        .resizable()
//                        .foregroundColor(Color("customCyan"))
//                        .frame(width: 10, height: 5, alignment: .center)
                    //                                .padding()
                    Text("Filters")
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
                List(filterOptions, id: \.self){
                    element in
                    MultiSelectRow(model: element, selectedItems: $selectedRows)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 20)
        }
        
    }
    
}


struct DropDownMenuFilters_Previews: PreviewProvider {
    static var previews: some View {
      DropDownMenuFilters()
    }
}


