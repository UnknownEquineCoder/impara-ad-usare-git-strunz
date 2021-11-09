//
//  ProfileNameLabel.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct ProfileNameLabel: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var name : String
    @Binding var image_Data : Data?
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Hello,")
                .fontWeight(.regular)
                .font(.system(size: 25.toFontSize()))
                .scaledToFit()
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 95)
            
//            if name.isEmpty {
//                            Text("Placeholder Text")
//                        }
            
//            TextEditor(text: $name).background(Color.clear)
//                .onChange(of: name, perform: { _ in
//                PersistenceController.shared.update_Profile(image: image_Data, name: name)
//            })
//                .font(.system(size: 25.toFontSize()))
//                .textFieldStyle(PlainTextFieldStyle())
//                .font(Font.headline.weight(.regular))
//                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
//                .multilineTextAlignment(.leading)
//                .fixedSize(horizontal: false, vertical: true)
//                .lineLimit(3)
            
            TextField("Name", text: $name, onCommit: {
                PersistenceController.shared.update_Profile(image: image_Data, name: name)
            })
                .font(.system(size: 25.toFontSize()))
                .textFieldStyle(PlainTextFieldStyle())
                .font(Font.headline.weight(.regular))
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                
            
        }
    }
}

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear //<<here clear
            drawsBackground = true
        }

    }
}
