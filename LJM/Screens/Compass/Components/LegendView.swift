//
//  LegendView.swift
//  LJM
//
//  Created by Laura Benetti on 02/03/21.
//

import Foundation
import SwiftUI

struct LegendView: View{
    var body: some View{
        HStack{
            Rectangle()
                .fill(Color(red: 6/255, green: 153/255, blue: 146/255))
                .frame(width: 18.toScreenSize(), height: 14.toScreenSize())
            Text("My progress")
                .fontWeight(.light)
                .font(.system(size: 16.toFontSize()))
            Spacer()
            
            Rectangle()
                .fill(Color(red: 120/255, green: 224/255, blue: 144/255))
                .frame(width: 18.toScreenSize(), height: 14.toScreenSize())
            Text("Expectations")
                .fontWeight(.light)
                .font(.system(size: 16.toFontSize()))
            
                
        }.frame(width: 226)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
       LegendView()
    }
}
