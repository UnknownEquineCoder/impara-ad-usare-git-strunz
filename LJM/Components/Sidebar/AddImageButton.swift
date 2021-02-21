//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI
import AppKit


struct AddImageButton: View {
    var buttonSize: CGFloat
    @Binding var imageName: String
    
    var body: some View {
        Button{
            let dialog = NSOpenPanel();

            dialog.title                   = "Choose an image"
            dialog.showsResizeIndicator    = true
            dialog.showsHiddenFiles        = false
            dialog.allowsMultipleSelection = false
            dialog.canChooseFiles = true
            dialog.canChooseDirectories = true
            dialog.allowedFileTypes        = ["png", "jpg", "jpeg", "gif"]

            if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                let result = dialog.url // Pathname of the file

                if let result = result {
                    let path: String = result.path
                    print(path)
                    self.imageName = path
                    
                    let image = NSImage(byReferencingFile: path)!
                    let data = image.tiffRepresentation
                    
                    UserDefaults.standard.set(data, forKey: "propic")
                    
                    
                    
                    
                    
                    
                    // path contains the file path e.g
                    // /Users/ourcodeworld/Desktop/tiger.jpeg
                }
                
            } else {
                // User clicked on "Cancel"
                return
            }
        }label: {
            ZStack{
                Circle()
                    .foregroundColor(.white)
//                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(Color(red: 89/255, green: 91/255, blue: 93/255, opacity: 1.0))
                
            }
            .shadow(color: Color.black.opacity(0.36), radius: 5, x: 0, y: 5)
        }
        .frame(width: buttonSize.toScreenSize(), height: buttonSize.toScreenSize(), alignment: .center)
        .buttonStyle(PlainButtonStyle())
        
        
    }
}

struct AddImageButton_Previews: PreviewProvider {
    static var previews: some View {
        //AddImageButton(buttonSize: 100, imageName: "")
        Text("")
    }
}
