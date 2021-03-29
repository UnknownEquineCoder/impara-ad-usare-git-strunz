//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI


struct ProfileImage: View {
    @AppStorage("propic") var data: Data = Data()
    @State var toToggle: Bool = false
    
    var body: Image {
        imageBody
    }
    
    var imageBody: Image {
        if let nsImage = NSImage(data: data) {
            defer { self.toToggle.toggle() }
            return Image(nsImage: nsImage)
        } else {
            defer { self.toToggle.toggle() }
            return Image("Student")
        }
    }
}

struct StudentPictureView: View {
    var size: CGFloat = 140
    @State var imageName: String = "student"
    
    
    var profileImage: Image {
        get {
            if let data = UserDefaults.standard.data(forKey: "propic"), let image = NSImage(data: data) {
                return Image(nsImage: image)
            } else {
                return Image("student")
            }
        }
    }
    
    
    var body: some View {
        HStack{
            ZStack{
                ProfileImage().body
                //Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                    .cornerRadius(250)
                    .padding()
                    .shadow(color: Color.black.opacity(0.36), radius: 5, x: 0, y: 5)
                Circle()
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("Light green"), Color("Dark green")]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                AddImageButton(buttonSize: (size/4).toScreenSize(), imageName: $imageName)
                    .padding([.top, .leading], 0.66*size.toScreenSize())
                
            }
            
            ProfileNameLabel(qualifiedName: "James Harden").frame(width: 150)
                
        }
        .padding(.trailing)
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

