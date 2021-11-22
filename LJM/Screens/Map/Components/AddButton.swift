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
    
    @State var hovered = false
    @State private var showingPopup:Bool = false
    @State private var showingAlert = false

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
//                        .popover(isPresented: $hovered) {
//                            PopoverView()
//                        }
                    
                    if learningObjectiveSelected.eval_score.isEmpty {
                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!
                        
                        if didTap == false {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color("customCyan"))
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
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color("customCyan"))
                                .onTapGesture {
                                    // remove item from the learning objective list
                                    if learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.count > 1 {
                                        // pop up
                                        
                                        showingAlert = true
                                        
                                        didTap = false

                                        
                                    } else {
                                        
                                        learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                        
                                        didTap = false

                                    }
                                }
                                .alert(isPresented:$showingAlert) {
                                    Alert(
                                        title: Text("Are you sure you want to delete this Learning Objective?"),
                                        message: Text("You can't undo this action"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!

                                            learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                            print("Deleting...")
                                        },
                                        secondaryButton: .cancel()
                                    )
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

                                if learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.count > 1 {
                                    
                                    showingAlert = true
                                    
                                    didTap = false
                                    
                                } else {
                                    
                                    learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                    didTap = false
                                }
                                
                            }
                            .alert(isPresented:$showingAlert) {
                                Alert(
                                    title: Text("Are you sure you want to delete this Learning Objective?"),
                                    message: Text("You can't undo this action"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObjectiveSelected.ID})!

                                        learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)
                                        print("Deleting...")
                                    },
                                    secondaryButton: .cancel()
                                )
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
            Button {
                
            } label: {
                Text("Undo")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

