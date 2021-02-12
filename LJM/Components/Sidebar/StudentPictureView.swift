//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct StudentPictureView: View {
    var size: CGFloat = 140
    var body: some View {
        HStack{
            ZStack{
                Image("student")
                    .resizable()
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                    .cornerRadius(250)
                    .padding()
                    .shadow(color: Color.black.opacity(0.36), radius: 5, x: 0, y: 5)
                Circle()
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("Light green"), Color("Dark green")]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                AddImageButton(buttonSize: (size/4).toScreenSize())
                    .padding([.top, .leading], 0.66*size.toScreenSize())
                
            }
            
            ProfileNameLabel(qualifiedName: "Student Name so so so long").frame(width: 150)
                
        }
        .padding(.trailing)
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

