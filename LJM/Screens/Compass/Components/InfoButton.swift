//
//  InfoButton.swift
//  LJM
//
//  Created by Laura Benetti on 23/06/21.
//

import SwiftUI

struct InfoButton: View {
    @State private var showPopover = false
    @State private var isHover = false
    var title: String = "Titolo"
    var textBody: String = "Body"
    var heightCell: CGFloat
    @State private var hoveredInfoButton = false
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
                        .font(.system(size: 20.toFontSize()))
                        .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 165/255, green: 165/255, blue: 165/255))
                }
                .frame(width: 400, height: 250)
                .padding()
            })
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    private struct CustomButtonStyleView<V: View>: View {
        @State private var isOverButton = false
        
        let content: () -> V
        
        var body: some View {
            content()
                .onHover { over in
                    self.isOverButton = over
                    print("isOverButton:", self.isOverButton, "over:", over)
                }
                .overlay(VStack {
                    if self.isOverButton {
                        Image(systemName: "info.circle.fill").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
                            .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
                    } else {
                        EmptyView()
                    }
                })
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        CustomButtonStyleView { configuration.label }
    }
    
    struct InfoButton_Previews: PreviewProvider {
        static var previews: some View {
            InfoButton(heightCell: 300)
        }
    }
    
}
