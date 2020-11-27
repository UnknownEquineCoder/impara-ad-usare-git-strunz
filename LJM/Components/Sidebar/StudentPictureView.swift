//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct StudentPictureView: View {
    var size: CGFloat = 100
    var body: some View {
        HStack{
            ZStack{
                Image("student")
                    .resizable()
                    .frame(width: size, height: size, alignment: .leading)
                    .cornerRadius(250)
                Circle()
                    .strokeBorder(Color.yellow, lineWidth: 3)
                    .frame(width: size, height: size, alignment: .leading)
                AddImageButton(buttonSize: size/4)
                    .padding([.top, .leading], 0.66*size)
                
            }
            
            ProfileNameLabel(qualifiedName: "Student Name")
                
        }
        .padding(.trailing)
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

