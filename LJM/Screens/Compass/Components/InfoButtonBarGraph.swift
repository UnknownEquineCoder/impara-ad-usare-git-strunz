//
//  InfoButton.swift
//  LJM
//
//  Created by Laura Benetti on 27/10/21.
//

import SwiftUI

struct InfoButtonBarGraph: View {
    @State private var showPopover = false
    @State private var hoveredInfoButton = false

    var title: String = "Titolo"
    var textBody: String = "Body"
    var heightCell: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            self.showPopover =  true
        }) {
            Image(systemName: hoveredInfoButton ? "info.circle.fill" : "info.circle").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
                .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
        }.buttonStyle(PlainButtonStyle())
            .onHover { hovered in
                hoveredInfoButton = hovered
            }
            .popover(isPresented: $showPopover, arrowEdge: .trailing, content: {
                VStack{
                    Text(textBody)
                        .fontWeight(.light)
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 110/255, green: 110/255, blue: 110/255))
                }
                .frame(width: 300, height: 110)
                .padding()
            })
    }
}


struct InfoButtonBarGraph_Previews: PreviewProvider {
    static var previews: some View {
        InfoButtonBarGraph(heightCell: 300)
    }
}
