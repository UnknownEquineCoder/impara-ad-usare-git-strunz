//
//  RatingView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/11/2020.
//

import SwiftUI

struct RatingView: View {
    
    var learningObjectiveSelected: LearningObjective
    @Binding var rating: Int
    @State private var hover = false
    var maximumRating = 5
    
    @EnvironmentObject var studentLearningObjectivesStore: StudentLearningObjectivesStore
    
    var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(learningObjectiveSelected.coreRubricLevel != nil ? Color.customCyan : Color.clear)
                .offset(x: setupGoalRating())
            
            HStack {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    Button {
                        self.rating = number
                        self.hover = false
                        print("JUHYGUHI \(learningObjectiveSelected.assessments)")
                        
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
                .foregroundColor(Color.customCyan)
            
        }
    }
    
    func setupGoalRating() -> CGFloat {
        switch learningObjectiveSelected.coreRubricLevel {
        case 1:
            return -85
        case 2:
            return -44
        case 3:
            return 0
        case 4:
            return 44
        case 5:
            return 85
        default:
            return 0
        }
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
                PopOverViewRating(showingPopup: $showingPopup)
                    .background(Color.white).border(Color.white)
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
