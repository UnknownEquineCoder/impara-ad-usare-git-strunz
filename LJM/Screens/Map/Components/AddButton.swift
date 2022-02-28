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
    
    var strandColor: Color

    var learningObjectiveSelected: learning_Objective
    
    @State var hovered = false
    @State private var showingPopup:Bool = false
    @State var showingAlertImport = false
    
    @Binding var rating: Int
    
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
        VStack {
            
            CountDownWrapper<AddLabelView>()
                .opacity(didTap ? 1 : 0)
            
            Button(action: {
                self.didTap.toggle()
            }){
                ZStack {
                    Text("")
                        .padding(.bottom, 30)
                    
                    if learningObjectiveSelected.eval_score.isEmpty {
                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!
                        
                        if didTap == false {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(strandColor)
                                .onHover(perform: { hover in
                                    if hover {
                                        self.hovered = true
                                        self.showingPopup = true
                                    } else {
                                        self.hovered = false
                                        self.showingPopup = false
                                    }
                                })
                                .onTapGesture {
                                    let new_Date = Calendar.current.date(bySettingHour: 0, minute: 1, second: 0, of: Date())!
                                    
                                    learningObjectiveStore.evaluate_Object(index: learningObjectiveIndex, evaluation: 1, date: new_Date)
                                    
                                    self.rating = 1

                                    self.didTap.toggle()
                                }
                        } else {
                            if #available(macOS 12.0, *) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(strandColor)
                                    .onTapGesture {
                                        // remove item from the learning objective list
                                        if learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.count > 1 {
                                            // pop up
                                            
                                            showingAlertImport = true
                                        } else {
                                            learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                            
                                            didTap = false
                                            
                                        }
                                    }
                                
                                    .alert("Are you sure you want to remove this Learning Objective ?", isPresented: $showingAlertImport) {
                                        Button("No", role: .cancel) {
                                            
                                        }
                                        
                                        Button("Yes", role: .cancel) {
                                            learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                            didTap = false
                                        }
                                    }
                            } else {
                                // Fallback on earlier versions
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(strandColor)
                                    .onTapGesture {
                                        // remove item from the learning objective list

                                        learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                        
                                        didTap = false
                                    }
                                
                            }                        }
                    } else {
                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!
                        
                        if #available(macOS 12.0, *) {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(strandColor)
                                .onTapGesture {
                                    
                                    // remove item from learning objective list
                                    
                                    if learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.count > 1 {
                                        
                                        showingAlertImport = true
                                    } else {
                                        learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                        
                                        didTap = false
                                    }
                                    
                                }
                                .alert("Are you sure you want to remove this Learning Objective ?", isPresented: $showingAlertImport) {
                                    Button("No", role: .cancel) {
                                        
                                    }
                                    
                                    Button("Yes", role: .cancel) {
                                        
                                        learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                        didTap = false
                                    }
                                }
                        } else {
                            // Fallback on earlier versions
                            
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(strandColor)
                                .onTapGesture {
                                    // remove item from the learning objective list

                                    learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                    
                                    didTap = false
                                }
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
        Text("Added to Journey!")
            .foregroundColor(Color.accentColor)
    }
}

struct UndoView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View {
        HStack {
            Text("\(counter.value)")
                .foregroundColor(Color.accentColor)
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke().foregroundColor(Color.gray))
            Button {
                
            } label: {
                Text("Undo")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

