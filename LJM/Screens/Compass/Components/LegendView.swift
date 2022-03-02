//
//  LegendView.swift
//  LJM
//
//  Created by Laura Benetti on 02/03/21.
//

import Foundation
import SwiftUI

struct LegendView: View{
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        HStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorScheme == .dark ? Color.front_graph_dark_mode : Color.front_graph_light_mode)
                .frame(width: 18.toScreenSize(), height: 14.toScreenSize())
            Text("My progress")
                .fontWeight(.light)
                .font(.system(size: 16.toFontSize()))
            Spacer()
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorScheme == .dark ? Color.back_graph_dark_mode : Color.back_graph_light_mode)
                .frame(width: 18.toScreenSize(), height: 14.toScreenSize())
            Text("Expectations")
                .fontWeight(.light)
                .font(.system(size: 16.toFontSize()))
            
                
        }.frame(width: 250)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
       LegendView()
    }
}
