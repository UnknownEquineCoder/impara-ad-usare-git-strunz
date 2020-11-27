//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct StudentPictureView: View {
    var size: CGFloat = 130
    var body: some View {
        HStack{
            ZStack{
                Image("student")
                    .resizable()
                    .frame(width: size, height: size, alignment: .leading)
                    .cornerRadius(250)
                Circle()
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color(red:133/255, green: 232/255, blue: 148/255, opacity: 1.0), Color(red:57/255, green: 172/255, blue: 169/255, opacity: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 5)
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

