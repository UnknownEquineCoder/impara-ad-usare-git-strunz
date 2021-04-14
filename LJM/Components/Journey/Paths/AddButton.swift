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
    var learningObjectiveSelected: LearningObjective
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    
    
    var buttonSize: CGFloat
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var didTap: Bool = false
    @State private var counter: Int = 5 {
        didSet {
            print(counter)
            if counter <= 0 {
                didTap = false
                print("Tieni le corna")
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
                    if !checkStudentContainsLearningObjective(learningObjectiveId: self.learningObjectiveSelected.id ?? "No id") {
                        if didTap == false{
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundColor(Color("customCyan"))
                                .onTapGesture {
                                    if learningObjectiveSelected.id != nil {
                                        Webservices.addAssessment(learningObjId: learningObjectiveSelected.id!, value: 0) { (assessment, err) in
                                            if err == nil {
                                                self.studentLearningObjectivesStore.addItem(learningObjectiveSelected)
                                            }
                                        }
                                    }
                                }
                        }else{
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color("customCyan"))
                                .onTapGesture {
                                    if learningObjectiveSelected.id != nil {
                                        Webservices.deleteLearningObjectiveFromStudentJourney(id: learningObjectiveSelected.id!) { value, error in
                                            if error == nil {
                                                self.studentLearningObjectivesStore.removeItem(learningObjectiveSelected)
                                            }
                                        }
                                    }
                                }
                        }
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color("customCyan"))
                    }
                }
                
            }
            .frame(width: buttonSize.toScreenSize(), height: buttonSize.toScreenSize(), alignment: .center)
            .buttonStyle(PlainButtonStyle())
            
            
            //            CountDownWrapper<UndoView>()
            //                .opacity(didTap ? 1 : 0)
            
        }
        
    }
    
    func checkStudentContainsLearningObjective(learningObjectiveId : String) -> Bool {
        var isAdded = false
        for studentLearningObjective in studentLearningObjectivesStore.learningObjectives {
            if studentLearningObjective.id == learningObjectiveId {
                isAdded = true
                return true
            }
        }
        return isAdded
    }
}

//struct AddButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AddButton(buttonSize: 100)
//    }
//}

struct AddLabelView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View{
        Text("Added to My Journey!")
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
                print()
            }label:{
                Text("Undo")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

