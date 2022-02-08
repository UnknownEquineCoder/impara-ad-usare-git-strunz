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
            if let _imageData = imageData {
                if let nsImageData = NSImage(data: _imageData) {
                    defer { self.toToggle.toggle() }
                    return Image(nsImage: nsImageData)
                }
            }
            
            return Image("UserPlaceholder")
            
        } else if let nsImage = NSImage(data: data) {
            defer { self.toToggle.toggle() }
            return Image(nsImage: nsImage)
        } else {
            defer { self.toToggle.toggle() }
            return Image("UserPlaceholder")
        }
    }
}

struct StudentPictureView: View {
    
    @StateObject var learningObjectiveStore = LearningObjectivesStore()
    @Environment(\.colorScheme) var colorScheme
    
    // core data elements
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var student: FetchedResults<Student>
    
    var size: CGFloat = 50
    @State var imageName: String = "UserPlaceholder"
    @State var imageData : Data?
    @State var username : String = "Name"
    let shared = singleton_Shared.shared
    
    var profileImage: Image {
        get {
            if let _imageData = imageData{
                if let _nsImageData = NSImage(data: _imageData){
                    return Image(nsImage: _nsImageData)
                }
                
            } else {
                return Image(imageName)
            }
            
            return Image("UserPlaceholder")
        }
    }
    
    
    var body: some View {
        HStack(spacing: 10){
            ProfileImage( imageData: $imageData).body
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.toScreenSize(), height: size.toScreenSize())
                .cornerRadius(250)
                .shadow(color: Color.black.opacity(0.36), radius: 5, x: 0, y: 5)
                .onAppear {
                    if let first_Student = student.last{
                        
                        if let image_Data = first_Student.image as? Data{
                            imageData = image_Data
                        }
                        
                        
                        if let student_Name = first_Student.name {
                            username = student_Name
                            PersistenceController.shared.name = student_Name
                        }
                    }
                }
                .onTapGesture {
                    openImagePicker()
                }
            
            Text(NSFullUserName())
                .font(.system(size: 13))
                .foregroundColor(Color.sidebarTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
            
        }
        .padding([.leading, .bottom, .trailing])
        
    }
    
    func openImagePicker() {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose an image"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false
        dialog.allowedFileTypes        = ["png", "jpg", "jpeg", "gif"]
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if let result = result {
                let path: String = result.path
                print(path)
                self.imageName = path
                
                let image = NSImage(byReferencingFile: path)!
                let data = image.tiffRepresentation
                
                if let image_Data = data {
                    if learningObjectiveStore.isSavable {
                        PersistenceController.shared.update_Profile(image: image_Data, name: username)
                    }
                    
                    imageData = image_Data
                }
                
            }
    }
    }
}

struct StudentPictureView_Previews: PreviewProvider {
    static var previews: some View {
        StudentPictureView()
    }
}

