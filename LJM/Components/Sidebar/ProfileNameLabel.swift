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
                .fixedSize(horizontal: true, vertical: true)
                .padding(.trailing, 95)
            
            TextField("Name Surname", text: $name, onCommit: {
                PersistenceController.shared.update_Profile(image: image_Data, name: name)
            })
                .font(.system(size: 25.toFontSize()))
            .textFieldStyle(PlainTextFieldStyle())
            .font(Font.headline.weight(.regular))
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: true, vertical: true)
                .lineLimit(3)
                .scaledToFit()
            
            
//            Text(qualifiedName)
//                .fontWeight(.regular)
//                .font(.system(size: 28.toFontSize()))
//                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
//                .multilineTextAlignment(.leading)
////                .frame(width: 400, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
////                .font(.system(size: 60))
//
//                .fixedSize(horizontal: false, vertical: true)
//                .lineLimit(3)
//                .scaledToFit()
        }
    }
}

//struct ProfileNameLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileNameLabel(qualifiedName: "Student Name")
//    }
//}
