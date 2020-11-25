//
//  ProfileNameLabel.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct ProfileNameLabel: View {
    
    var body: some View {
        VStack{
            Text("Student Name bbbbbbbbbbb")
                .fontWeight(.regular)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
//                .frame(width: 400, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .font(.system(size: 60))

                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .scaledToFit()
        }
    }
}

struct ProfileNameLabel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileNameLabel()
    }
}
