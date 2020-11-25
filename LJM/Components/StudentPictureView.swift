//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct StudentPictureView: View {
    var body: some View {
        HStack{
            ZStack{
                Image("student")
                    .resizable()
                    .frame(width: 500, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(250)
                Circle()
                    .strokeBorder(Color.yellow, lineWidth: 10)
                    .frame(width: 500, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                AddImageButton(buttonSize: 100)
                .padding([.top, .leading], 345)
            }

        }
        .padding()
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

