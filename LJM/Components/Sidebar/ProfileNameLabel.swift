//
//  ProfileNameLabel.swift
//  LJM
//
//  Created by Laura Benetti on 25/11/20.
//

import Foundation
import SwiftUI

struct ProfileNameLabel: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var name : String
    @Binding var image_Data : Data?
    
    @State var timer: Timer?
    
    @StateObject var learningObjectiveStore = LearningObjectivesStore()
    
    var body: some View {
//        VStack(spacing: 5){
//            Text("Hello,")
//                .fontWeight(.regular)
//                .font(.system(size: 25.toFontSize()))
//                .scaledToFit()
//                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
//                .fixedSize(horizontal: false, vertical: true)
//                .padding(.trailing, 95)
            
            TextField("Your name here", text: $name)
                .cursor(.pointingHand)
                .onChange(of: name) { newName in
                    if timer != nil{
                        timer!.invalidate()
                    }
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                        if(newName != ""){
                            if learningObjectiveStore.isSavable {
                                PersistenceController.shared.update_Profile(image: image_Data, name: newName)
                            }
                            
                        }
                    }
                    
                }
                .font(.system(size: 18.toFontSize()))
                .textFieldStyle(PlainTextFieldStyle())
                .font(Font.headline.weight(.regular))
                .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .cursor(.pointingHand)
            
            
//        }
    }
}
