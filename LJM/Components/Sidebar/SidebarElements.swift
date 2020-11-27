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
            ZStack{
                Image(buttonIcon)
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.green)
                    .padding(.trailing, 115)
                
                Text(buttonName)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
    
    
}

struct Navigation: View{
    var buttonName: String
    var buttonIcon: String
    var body: some View{
        NavigationLink(destination: Text("Destination"),
                       label: {
                        SidebarElements(buttonName: buttonName, buttonIcon: buttonIcon)
                       })
    }
    
    
    
    struct SidebarElements_Previews: PreviewProvider {
        static var previews: some View {
            SidebarElements(buttonName: "Placeholder", buttonIcon: "square")
        }
    }
}
