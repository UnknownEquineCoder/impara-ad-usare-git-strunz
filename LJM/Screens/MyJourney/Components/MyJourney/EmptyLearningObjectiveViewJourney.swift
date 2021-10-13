//
//  EmptyLearningObjectiveViewJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct EmptyLearningObjectiveViewJourney: View {
    
    @Binding var selectedMenu: OutlineMenu
    
    let addObjText = "Add a learning objective"
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                Text("The Learning Objective is half the journey !")
                    .font(.system(size: 45, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customBlack)
                
                Text("Tap the button to add the first one.")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customDarkGrey)
                    .padding(.top, 20)
                
                Button(action: {
                    self.selectedMenu = .map
                }) {
                    Text(addObjText.uppercased())
                        .padding()
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.customCyan)
                        .frame(width: 250, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(50)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(lineWidth: 2).foregroundColor(Color.customCyan))
                    
                }.buttonStyle(PlainButtonStyle())
                .padding(.top, 20)
            }
        }.padding(.top, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(BackgroundImageReadingStudent().allowsHitTesting(false).frame(width: 1500, height: 700, alignment: .center).padding(.bottom, 350).padding(.trailing, 240))
    }
}
