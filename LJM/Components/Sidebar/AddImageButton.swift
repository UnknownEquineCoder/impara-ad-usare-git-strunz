//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI


struct AddImageButton: View {
    var buttonSize: CGFloat
    var body: some View {
        Button{
            print()
        }label: {
            ZStack{
                Circle()
                    .foregroundColor(.white)
//                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(Color(red: 89/255, green: 91/255, blue: 93/255, opacity: 1.0))
            }
        }
        .frame(width: buttonSize, height: buttonSize, alignment: .center)
        .buttonStyle(PlainButtonStyle())
        
        
    }
}

struct AddImageButton_Previews: PreviewProvider {
    static var previews: some View {
        AddImageButton(buttonSize: 100)
    }
}
