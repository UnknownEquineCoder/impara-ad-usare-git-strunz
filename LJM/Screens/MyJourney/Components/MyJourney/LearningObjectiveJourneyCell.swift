import SwiftUI

struct LearningObjectiveJourneyCell: View {
    @State var rating = 0
    @State var expand: Bool = false
    @State var isRatingView: Bool
    var value : Int = 0
    @Environment(\.colorScheme) var colorScheme
    
    var isAddable = false
    var isLearningGoalAdded: Bool?
    @Binding var learningPathSelected : String?
    
    var learningObj: learning_Objective
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: learningObj.strand))
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(learningObj.strand.uppercased())
                                .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: learningObj.strand))
                                .font(.system(size: learningObj.strand.count > 15 ? 15 : 20, weight: .semibold, design: .rounded))
                                .lineLimit(2)
                            Text(learningObj.goal_Short.uppercased())
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .light))
                                .lineLimit(2)
                            Text(learningObj.isCore ? "CORE" : "ELECTIVE")
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .light))
                                .lineLimit(2)
                        }.frame(width: 200, alignment: .leading).padding(.leading, 20).padding(.top, 15)
                        
                        Spacer().frame(width: 50)
                        
                        Text(learningObj.description)
                            .foregroundColor(colorScheme == .dark ? Color(red: 224/255, green: 224/255, blue: 224/255) : Color.customLightBlack)
                            .font(.system(size: 24.toFontSize(), weight: .regular))
                            .frame(maxWidth: 400, maxHeight: .infinity, alignment: .leading)
                            .lineLimit(self.expand ? nil : 4).padding()
                        
                        Spacer()
                        
                        if self.isLearningGoalAdded != nil {
                            if learningObj.eval_score.count > 0 {
                                RatingView( learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.top, 15).padding(.trailing, 30)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, buttonSize: 27).padding(.trailing, 60).padding(.top, 20)
                            }
                        } else {
                            if !isAddable {
                                RatingView( learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.top, 15).padding(.trailing, 30)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, buttonSize: 27).padding(.trailing, 60).padding(.top, 20)
                            }
                        }
                    }.padding(.leading, 20)
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.trailing, 60)
                            
                            HStack {
                                Text("KEYWORDS").foregroundColor(Color.customDarkGrey)
                                    .font(.system(size: 17, weight: .light))
                                    .frame(width: 150, alignment: .leading)
                                
                                Spacer()
                                
                                Text("#\(learningObj.Keyword.joined(separator: " #"))")
                                    .foregroundColor(Color.customLightBlack)
                                    .font(.system(size: 16, weight: .medium))
                                    .lineLimit(4)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .padding(.leading, 110).padding(.trailing, 50)
                                    .frame(height: 50)
                                
                                Spacer()
                            }
                            
                            Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.trailing, 60)
                            
                            HStack {
                                Text("HISTORY").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light)).frame(width: 150, alignment: .leading)
                                Spacer().frame(width: 100)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        
                                        ForEach(0..<learningObj.eval_score.count, id: \.self) { index in
                                            
                                            HistoryProgressView(index: index, learningObj: self.learningObj)
                                            
                                        }
                                    }
                                }
                                
                                Spacer().frame(width: 50)
                            }
                        }.padding(.leading, 40).padding(.bottom, 50)
                    }
                    .frame(maxWidth: 1402.toScreenSize(), maxHeight: self.expand ? 250 : 0, alignment: .topLeading)
                    .padding(.trailing, 250)
                    .isHidden(self.expand ? false : true)
                }
                
                VStack(alignment: .center, spacing: 5) {
                    Spacer().frame(height: 200)
                    Text(setupTitleProgressRubric(value: learningObj.eval_score.last ?? 0))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.customCyan)
                    Text(setupDescProgressOnRubric(value: learningObj.eval_score.last ?? 0))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color.customDarkGrey)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 200)
                }.frame(width: 260, height: 100, alignment: .center)
                    .isHidden(self.isAddable ? true : false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .isHidden(self.expand ? false : true)
                
                HStack {
                    Divider()
                        .background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.top, 20).padding(.bottom, 20).padding(.trailing, 250)
                        .isHidden(self.isRatingView ? false : true)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .zIndex(1)
                
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.customCyan)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            }
        }
        .background(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255) : Color(red: 230/255, green: 230/255, blue: 230/255))
        .cornerRadius(14)
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
        }
        
    }
    
    func setupTitleProgressRubric(value: Int) -> String {
        switch value {
        case 0:
            return ""
        case 1:
            return "NOT EVALUATED"
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
            return "The LO has been added to your Journey but you have not evaluated yourself."
        case 2:
            return "You have been exposed to the Learning Objective Content."
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
    
    func setupColor(darkMode: Bool, strand: String) -> Color {
        
        switch strand {
        case "Design":
            return .customGreen
        case "Process":
            return .customOrange
        case "App Business and Marketing":
            return .customPurple
        case "Professional Skills":
            return .customYellow
        case "Technical":
            return .customBlue
            
        default:
            return Color.customCyan
            
        }
    }
}

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0
    
    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }
    
    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}
