//
//  InfoButton.swift
//  LJM
//
//  Created by Laura Benetti on 27/10/21.
//

import SwiftUI

struct InfoButtonBarGraph: View {
    @State private var showPopover = false
    var title: String = "Titolo"
    var textBody: String = "Body"
    var heightCell: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            self.showPopover =  true
        }) {
            Image(systemName: "info.circle").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
                .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
        }
        .buttonStyle(CustomButtonStyleBarGraph())
//        .buttonStyle(PlainButtonStyle())
            .popover(isPresented: $showPopover, arrowEdge: .trailing, content: {
                VStack{
                    Text(textBody)
                        .fontWeight(.light)
                        .font(.system(size: 20.toFontSize()))
                        .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 165/255, green: 165/255, blue: 165/255))
                }
                .frame(width: 200, height: 150)
                .padding()
            })
    }
}

struct CustomButtonStyleBarGraph: ButtonStyle {
    
    private struct CustomButtonStyleView<V: View>: View {
        @State private var isOverButton = false
        
        let content: () -> V
        
        var body: some View {
            content()
                .onHover { over in
                    self.isOverButton = over
                    print("isOverButton:", self.isOverButton, "over:", over)
                }
            
//                .onHover { hover in
//                    if hover {
//                        self.hovered = true
//                    } else {
//                        self.hovered = false
//                        self.showingPopup = false
//                    }
            
//                .onHover { over in
//                    if over{
//                    self.isOverButton = true
//                    print("isOverButton:", self.isOverButton, "over:", over)
//                        Image(!isOverButton ? "info.circle.fill" : "info.circle").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
//                            .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
//                    }else{
//                        self.isOverButton = false
//                    }
//                }
            
                .overlay(VStack {
                    Image(!isOverButton ? "info.circle.fill" : "info.circle").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
                        .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
                })
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        CustomButtonStyleView { configuration.label }
    }
    
    struct InfoButtonBarGraph_Previews: PreviewProvider {
        static var previews: some View {
            InfoButtonBarGraph(heightCell: 300)
        }
    }
    
}
