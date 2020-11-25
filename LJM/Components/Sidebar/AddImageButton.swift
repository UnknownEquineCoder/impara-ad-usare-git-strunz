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
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
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
