//
//  SidebarElements.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI


struct SidebarElements: View {
    var buttonName: String
    var buttonIcon: String
    var body: some View {
        HStack{
            Image(buttonIcon)
                .resizable()
                .frame(width: 37, height: 37, alignment: .center)
                .foregroundColor(.green)
                .padding(.trailing, 8)
            
            Text(buttonName)
                .font(.system(size: 28))
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
            
            
        }.padding(.leading, 37)
        .padding(.top, 13)
        .padding(.bottom, 13)
        .padding(.trailing, 8)
    }
    
    
}

struct Navigation<V: LJMView>: View{
    var buttonName: String
    var buttonIcon: String
    
    
    var body: some View{
        NavigationLink(destination: V(),
                       label: {
                        SidebarElements(buttonName: buttonName, buttonIcon: buttonIcon)
                       })
    }
    
}
struct SidebarElements_Previews: PreviewProvider {
    static var previews: some View {
        SidebarElements(buttonName: "Placeholder", buttonIcon: "square")
    }
}


