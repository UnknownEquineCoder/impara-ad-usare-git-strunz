//
//  AddImageButton.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/20.
//

import Foundation
import SwiftUI
import Combine


struct AddButton: View {
    var learningObjectiveSelected: learning_Objective
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var buttonSize: CGFloat
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var didTap: Bool = false
    @State private var counter: Int = 5 {
        didSet {
            if counter <= 0 {
                didTap = false
            }
        }
    }
    
    var body: some View {
        VStack{
            
            CountDownWrapper<AddLabelView>()
                .opacity(didTap ? 1 : 0)
            
            
            Button(action: {
                self.didTap.toggle()
            }){
                ZStack {
                    if learningObjectiveSelected.eval_score.isEmpty {
                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!
                        
                        if didTap == false {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color("customCyan"))
                                .onTapGesture {
                                    
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.append(1)
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.append(Date())
                                    
                                    self.didTap.toggle()
                                    
                                }
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color("customCyan"))
                                .onTapGesture {
                                    // remove item from the learning objective list
                                    
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.removeAll()
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.removeAll()
                                    
                                }
                        }
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color("customCyan"))
                            .onTapGesture {
                                
                                // remove item from learning objective list
                                
                                let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!
                                
                                self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.removeAll()
                                self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.removeAll()
                                
                        }
                    }
                }
            }
            .frame(width: buttonSize.toScreenSize(), height: buttonSize.toScreenSize(), alignment: .center)
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

struct AddLabelView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View{
        Text("Added to my Journey!")
            .foregroundColor(Color("customCyan"))
    }
}

struct UndoView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View {
        HStack {
            Text("\(counter.value)")
                .foregroundColor(Color("customCyan"))
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke().foregroundColor(Color.gray))
            Button{
                
            }label:{
                Text("Undo")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

