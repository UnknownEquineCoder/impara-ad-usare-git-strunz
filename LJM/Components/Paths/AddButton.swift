//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/20.
//

import Foundation
import SwiftUI


struct AddButton: View {
    var buttonSize: CGFloat
    var body: some View {
        Button{
            print()
        }label: {
            ZStack{

                Image(systemName: "plus.circle")
                    .resizable()
                    .foregroundColor(Color("customCyan"))
                
            }

        }
        .frame(width: buttonSize, height: buttonSize, alignment: .center)
        .buttonStyle(PlainButtonStyle())
        
        
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(buttonSize: 100)
    }
}

