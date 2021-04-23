//
//  EmptyLearningObjectiveViewJourney.swift
//  LJM
//
//  Created by Tony Tresgots on 04/12/2020.
//

import SwiftUI

struct EmptyLearningObjectiveViewJourney: View {
    
    let addObjText = "Add a learning objective"
    
    var body: some View {
        ZStack {
            BackgroundImageReadingStudent()
            
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

                }) {
                    Text(addObjText.uppercased())
                        .padding()
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(Color.customCyan)
                        .frame(width: 250, height: 50, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
                        .background(Color.white)
                    
                }.buttonStyle(PlainButtonStyle())
                .padding(.top, 20)
            }
        }
    }
}
