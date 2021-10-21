//
//  RatingView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/11/2020.
//

import SwiftUI

struct RatingView: View {
    
    @State var learningObj: learning_Objective
    
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
                .offset(x: setupGoalRating())
                .foregroundColor(Color.customCyan)
            
            HStack {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    Button {
                        self.rating = number
                        self.hover = false
                        
                        // Add assessment
                        let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
                        self.learningObjectiveStore.learningObjectives[learningObjectiveIndex].eval_score.append(number)
                        
                    } label: {
                        CircleView(number: number, rating: rating)
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Image(systemName: "arrowtriangle.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(learningObj.isCore ? Color.customLightGrey : Color.clear)
            
        }
    }
    
    func setupGoalRating() -> CGFloat {
        let fakePaths = ["Design", "Front","Back", "Game","Business"]
        let learningPathIndex = fakePaths.firstIndex(where: {$0 == learningPathSelected}) ?? 0
        //        Design,Front,Back,Game,Business

        let something  =  learningObj.core_Rubric_Levels[learningPathIndex + 1]
        
        if(something == 0) {
             return -88
        }
        
        return CGFloat((44 * (something)) - 132 - (something == 5 ? 3 : 0))

    }

}

struct CircleView: View {
    @State var hovered = false
    @State private var showingPopup:Bool = false
    var number = 0
    var rating = 0
    
    var body: some View {
        Circle()
            .strokeBorder(number > rating ? (hovered ? Color.customCyan : Color.customDarkGrey) : Color.clear, lineWidth: 2)
            .background(Circle().foregroundColor(number > rating ? Color.customLightGrey : Color.customCyan))
            .popover(isPresented: self.$showingPopup) {
                PopOverViewRating(showingPopup: $showingPopup, status: setupTitleProgressRubric(value: number), desc: setupDescProgressOnRubric(value: number))
                    .background(Color.white).border(Color.white)
                    .allowsHitTesting(false)
            }
            .onHover { hover in
                if hover {
                    self.hovered = true
                } else {
                    self.hovered = false
                    self.showingPopup = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if hovered {
                        if hover {
                            self.showingPopup = true
                        } else {
                            self.showingPopup = false
                        }
                    } else {
                        self.showingPopup = false
                    }
                }
            }
    }
    
    func setupTitleProgressRubric(value: Int) -> String {
        switch value {
        case 0:
            return ""
        case 1:
            return "NO EXPOSURE"
        case 2:
            return "BEGGINING"
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
            return ""
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
    @Binding var showingPopup: Bool
    var status = "Progressing"
    var desc = "You can understand and apply concepts with assistance."
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(status.uppercased())
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color.customCyan)
            Text(desc)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(Color.customDarkGrey)
                .multilineTextAlignment(.center)
        }.frame(width: 150, height: 50, alignment: .center).padding()
    }
}
