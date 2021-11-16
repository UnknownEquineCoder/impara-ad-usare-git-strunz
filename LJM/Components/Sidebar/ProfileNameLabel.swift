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
            
//            CustomTextEditor.init(placeholder: "Start typing..", text: $name)
//                                    .font(.body)
//                                    .background(Color.clear)
//                                    .accentColor(.green)
//                                    .frame(height: 25)
//                                    .cornerRadius(8)
//                                    .onChange(of: name, perform: { _ in
//                                        PersistenceController.shared.update_Profile(image: image_Data, name: name)
//                                    })
            
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

//struct CustomTextEditor: View {
//    let placeholder: String
//    @Binding var text: String
//    let internalPadding: CGFloat = 5
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            if text.isEmpty  {
//                Text(placeholder)
//                    .foregroundColor(Color.primary.opacity(0.25))
//                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
//                    .padding(internalPadding)
//            }
//            TextEditor(text: $text)
//                .padding(internalPadding)
//        }
//    }
//}

//extension NSTextView {
//    open override var frame: CGRect {
//        didSet {
//            backgroundColor = .clear //<<here clear
//            drawsBackground = true
//        }
//
//    }
//}
