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
    
    var body: some View {
        VStack {
        Button(action: {
            self.expand.toggle()
        }) {
            HStack{
                Image(systemName: "chevron.down")
                    .resizable()
                    .foregroundColor(Color("customCyan"))
                    .frame(width: 10, height: 5, alignment: .center)
//                                .padding()
                Text("Filters")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color("customCyan"))
                    
            }.frame(width: 130, height: 30, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.trailing, 20)

            
            if expand {
                   DropdownSection(names: ["Aldo", "Giovanni", "Giacomo"], sectionName: "Il Trio")
                }
        }
        
    }

}

struct DropdownSection: View {
    var names: [String]
    var sectionName: String
    
    var body: some View {
       
        Section(header: Text(sectionName).padding(.leading, 18)) {
            List {
                ForEach(names, id: \.self) { name in
                    DropdownItem(name: name)
                }
            }
            
        }.frame(width: 250, alignment: .top)
        
    
    }
}

//struct DropdownItem: View {
//    var name: String
//    @State var isSelected: Bool = false
//    
//    var body: some View {
//        HStack {
//            Text(name)
//            Spacer(minLength: 20)
//            Button{
//                self.isSelected.toggle()
//            }label:{
//                Image(systemName: isSelected ? "checkmark.square" : "square")
//                    .resizable()
//                    .frame(width: 22, height: 22)
//            }.buttonStyle(PlainButtonStyle())
//            
//        }
//        .frame(width: 150)
//    }
//}


struct DropDownMenuFilters_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        DropdownSection(names: ["Aldo", "Giovanni", "Giacomo"], sectionName: "Il Trio")
    }
    }
}


