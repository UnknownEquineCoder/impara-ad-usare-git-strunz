//
//  RatingView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/11/2020.
//

import SwiftUI

struct RatingView: View {

    @State var learningObj: learning_Objective
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var rating: Int
    @State private var hover = false
    var maximumRating = 5
    @Binding var learningPathSelected : String?
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    @EnvironmentObject var learningPathStore: LearningPathStore
    
    var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(learningPathSelected != nil ? .customCyan : .clear)
                .offset(x: setupGoalRating())
            
            HStack {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    CircleView( number: number, rating: rating)
                        .onTapGesture {
                            withAnimation {
                                self.rating = number
                                //                        self.hover = false
                                
                                // Add assessment
                                let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
                                
                                let new_Date = Calendar.current.date(bySettingHour: 0, minute: 1, second: 0, of: Date())!
                                
                                let index_To_Delete = self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.firstIndex(where: {$0 == new_Date})
                                
                                if let to_Delete = index_To_Delete {
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.remove(at: to_Delete)
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.remove(at: to_Delete)
                                }
                                
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.append(number)
                                    self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_date.append(new_Date)
                                    
                                    PersistenceController.shared.evalutate_Learning_Objective(l_Objective: self.learningObjectiveStore.learningObjectives[learningObjectiveIndex])
                            }
                                
                                
                            
                        }
                        .frame(width: 35, height: 35, alignment: .center)
                }
            }
            
            
            Image(systemName: "arrowtriangle.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(learningObj.isCore ? Color.customDarkGrey : Color.clear)
            
        }
    }
    
    func setupGoalRating() -> CGFloat {
        
        let learningPathIndex = learningPathStore.learningPaths.firstIndex(where: { $0.title.lowercased() == learningPathSelected?.lowercased() }) ?? 0
        
        //        Design,Front,Back,Game,Business
        
        let core_Rubric_Level  =  learningObj.core_Rubric_Levels[learningPathIndex]
        
        if (core_Rubric_Level == 0) {
            return -88
        }
        
        return CGFloat((44 * (core_Rubric_Level)) - 132 - (core_Rubric_Level == 5 ? 3 : 0))
    }
    
    
}

struct CircleView: View {
    @State var hovered = false
    @State private var showingPopup:Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var number = 1
    var rating = 1
    
    var body: some View {
        ZStack {
            Text("")
                .padding(.bottom, 30)
                .popover(isPresented: $hovered) {
                    PopOverViewRating(status: setupTitleProgressRubric(value: number), desc: setupDescProgressOnRubric(value: number))
                }
                        
            Circle()
                .strokeBorder(number > rating ? (hovered ? Color.customCyan : colorScheme == .dark ? Color(red: 154/255, green: 154/255, blue: 154/255) : Color.customDarkGrey) : Color.clear, lineWidth: 2)
                .background(Circle().foregroundColor(number > rating ? colorScheme == .dark ? Color(red: 73/255, green: 73/255, blue: 73/255) : Color.customLightGrey : Color.customCyan))
                .frame(width: 40, height: 40)
                .onHover { hover in
                    if hover {
                        self.hovered = true
                        self.showingPopup = true
                    } else {
                        self.hovered = false
                        self.showingPopup = false
                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        if hovered {
//                            if hover {
//                                self.showingPopup = true
//                            } else {
//                                self.showingPopup = false
//                            }
//                        } else {
//                            self.showingPopup = false
//                        }
//                    }
                }
            //            .popover(isPresented: self.$showingPopup) {
            //                PopOverViewRating(showingPopup: $showingPopup, status: setupTitleProgressRubric(value: number), desc: setupDescProgressOnRubric(value: number))
            //            }
        }
    }
    
    func setupTitleProgressRubric(value: Int) -> String {
        switch value {
        case 0:
            return ""
        case 1:
            return "NOT EVALUATED"
        case 2:
            return "BEGINNING"
        case 3:
            return "PROGRESSING"
        case 4:
            return "PROFICIENT"
        case 5:
            return "EXEMPLARY"
            
        default:
            return ""
            
        }
    }
    
    func setupDescProgressOnRubric(value: Int) -> String {
        switch value {
        case 0:
            return ""
        case 1:
            return "The LO has been added to your Journey but you have not evaluated yourself."
        case 2:
            return "You have been exposed to the content within the learning objective."
        case 3:
            return "You can understand and apply concepts with assistance."
        case 4:
            return "You understand the concepts, can analyze and evaluate when to use them and can apply them independently."
        case 5:
            return "You are a confident and creative learner of the concept and can serve as a guiding resource to others."
            
        default:
            return ""
            
        }
    }
    
    
}

struct PopOverViewRating: View {
    var status = "Progressing"
    var desc = "You can understand and apply concepts with assistance."
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(status.uppercased())
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color.customCyan)
            Text(desc)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color.customDarkGrey)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 160, height: 80, alignment: .center).padding()
    }
}
