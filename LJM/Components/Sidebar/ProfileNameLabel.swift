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
        VStack{
            Text("Hello,")
                .fontWeight(.regular)
                .font(.system(size: 25.toFontSize()))
                .scaledToFit()
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 95)
            
            TextField("Name", text: $name)
                .onChange(of: name) { newName in
                    if(newName != ""){
                        PersistenceController.shared.update_Profile(image: image_Data, name: newName)
                    }
                }
                .font(.system(size: 25.toFontSize()))
            .textFieldStyle(PlainTextFieldStyle())
            .font(Font.headline.weight(.regular))
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .scaledToFit()
            
        }
    }
}

extension String {
    init(sep:String, _ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += sep
            }
        }
    }

    init(_ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += "\n"
            }
        }
    }
}
