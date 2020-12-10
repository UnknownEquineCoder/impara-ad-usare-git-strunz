//
//  DropDownFilterMenu.swift
//  LJM
//
//  Created by Laura Benetti on 03/12/20.
//

import Foundation
import SwiftUI


struct DropDownFilterMenu: View {
    @State var isOn: Bool = false
    var body: some View {
        
        Menu{
            
            Section(header: Text("Strand")) {
                Toggle("Business", isOn: $isOn)
                Toggle("Coding", isOn: $isOn)
                Toggle("Design", isOn: $isOn)
            }
        }
        label: {
            Text("Filters")
                .foregroundColor(Color("customCyan"))
                .fontWeight(.semibold)
                .font(.system(size: 18.toFontSize()))
            
           
        }.colorScheme(.light)
        .frame(width: 240.toScreenSize(), height: 42.toScreenSize())
    }
    
}


struct DetectHover: ButtonStyle {
    @State private var hovering: Bool = false

    public func makeBody(configuration: DetectHover.Configuration) -> some View {
        configuration.label
            .foregroundColor(self.hovering ? Color.white : Color.primary)
            .background(self.hovering ? Color.blue : Color.clear)
            .onHover { hover in
                self.hovering = hover
            }
    }
}


struct RedMenu: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {

        
        
       Menu(configuration)
            .foregroundColor(.red)
        .accentColor(.green)
        .background(Color.red)
    }
}

struct DropdownItem: View {
    var name: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(name)
//            Spacer(minLength: 20)
            Button{
                self.isSelected.toggle()
            }label:{
                Image(systemName: isSelected ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 22.toScreenSize(), height: 22.toScreenSize())
            }.buttonStyle(PlainButtonStyle())
            
        }
        .frame(width: 150.toScreenSize())
    }
}



struct DropDownFilterMenu_Previews: PreviewProvider {
    
    static var previews: some View {
        DropDownFilterMenu()
    }
}



