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
    var qualifiedName: String
    var body: some View {
        VStack{
            Text(qualifiedName)
                .fontWeight(.regular)
                .font(.system(size: 28.toFontSize()))
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .multilineTextAlignment(.leading)
//                .frame(width: 400, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .font(.system(size: 60))

                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .scaledToFit()
        }
    }
}

struct ProfileNameLabel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileNameLabel(qualifiedName: "Student Name")
    }
}
