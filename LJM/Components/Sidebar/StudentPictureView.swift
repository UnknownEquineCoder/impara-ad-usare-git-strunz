//
//  StudentPictureView.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper

struct ProfileImage: View {
    @AppStorage("propic") var data: Data = Data()
    @State var toToggle: Bool = false
    @Binding var imageData : Data?
    
    var body: Image {
        imageBody
    }
    
    var imageBody: Image {
        if imageData != nil {
            defer { self.toToggle.toggle() }
            return Image(nsImage: NSImage(data: imageData!)!)
        } else if let nsImage = NSImage(data: data) {
            defer { self.toToggle.toggle() }
            return Image(nsImage: nsImage)
        } else {
            defer { self.toToggle.toggle() }
            return Image("profile-placeholder")
        }
    }
}

struct StudentPictureView: View {
    
    // core data elements
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var student: FetchedResults<Student>
    
    var size: CGFloat = 140
    @State var imageName: String = "profile-placeholder"
    @State var imageData : Data?
    let shared = singleton_Shared.shared
    
    var profileImage: Image {
        get {
            if imageData != nil {
                return Image(nsImage: NSImage(data: imageData!)!)
            } else {
                return Image(imageName)
            }
        }
    }
    
    
    var body: some View {
        HStack{
            ZStack{
                ProfileImage( imageData: $imageData).body
                //Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                    .cornerRadius(250)
                    .padding()
                    .shadow(color: Color.black.opacity(0.36), radius: 5, x: 0, y: 5)
                    .onAppear {
                        if let first_Student = student.first{
                            PersistenceController.shared.fetched_Profile = student
                            if let image_Data = first_Student.image as? Data {
                                imageData = image_Data
                            }
                        }
                    }
                
                Circle()
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color("Light green"), Color("Dark green")]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    .frame(width: size.toScreenSize(), height: size.toScreenSize(), alignment: .leading)
                AddImageButton(buttonSize: (size/4).toScreenSize(), imageName: $imageName, imageData: $imageData)
                    .padding([.top, .leading], 0.66*size.toScreenSize())
                
            }
            
            ProfileNameLabel(qualifiedName: "\(shared.profile_data.name)").frame(width: 150)
                .onTapGesture {
                    KeychainWrapper.standard.removeObject(forKey: "tokenAuth")
            
//            ProfileNameLabel(qualifiedName: "\(LJM.storage.user.name ?? "") \(LJM.storage.user.surname ?? "Surname")").frame(width: 150)
//                .onTapGesture {
//                    KeychainWrapper.standard.removeObject(forKey: "tokenAuth")
                }
        }
        .padding(.trailing)
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

