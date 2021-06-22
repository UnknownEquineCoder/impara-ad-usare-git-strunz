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
    
    var learningObj: LearningObjective

//    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    var body: some View {
        LazyVStack(spacing: 20) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .frame(width: 20, alignment: .topLeading)
                    .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: Strands(rawValue: learningObj.strand ?? "") ?? .TECHNICAL))

                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(learningObj.strand?.uppercased() ?? "No strand")
                                .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: Strands(rawValue: learningObj.strand ?? "") ?? .TECHNICAL))
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .lineLimit(2)
                            Text(learningObj.learningGoal?.uppercased() ?? "No title")
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .light))
                                .lineLimit(2)
                            Text(learningObj.isCore() ? "CORE" : "ELECTIVE")
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .light))
                                .lineLimit(2)
                        }.frame(width: 150, alignment: .leading).padding(.leading, 20).padding(.top, 15)

                        Spacer().frame(width: 100)

                        Text(learningObj.description ?? "No description")
                            .foregroundColor(colorScheme == .dark ? Color(red: 224/255, green: 224/255, blue: 224/255) : Color.customLightBlack)
                            .font(.system(size: 24.toFontSize(), weight: .regular))
                            .frame(maxWidth: 639.toScreenSize(), maxHeight: .infinity, alignment: .leading)
                            .lineLimit(self.expand ? nil : 4).padding()

                        Spacer()

                        if self.isLearningGoalAdded != nil {
                            if self.isLearningGoalAdded! {
                                RatingView(learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.top, 15).padding(.trailing, 30)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, buttonSize: 27).padding(.trailing, 32).padding(.top, 24)
                            }
                        } else {
                            if !isAddable {
                                RatingView(learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.top, 15).padding(.trailing, 30)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, buttonSize: 27).padding(.trailing, 32).padding(.top, 24)
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

                                Text("#\(learningObj.tags?.joined(separator: " #") ?? "")")
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
                                            ForEach((learningObj.assessments ?? [Assessment]())!) { item in
                                              //  if item == learningObj.assessments?.last || item == learningObj.assessments?.first {

                                             //   } else {
                                                if item == learningObj.assessments?.last {
                                                    HistoryProgressView(assessment: item, isDeletable: true, learningObj: self.learningObj)
                                                } else {
                                                    HistoryProgressView(assessment: item, learningObj: self.learningObj)
                                                }
                                             //  }
                                            }
                                        }
                                    }
//
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
                    Text(setupTitleProgressRubric(value: learningObj.assessments?.first?.score?.rawValue ?? 0))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.customCyan)
                    Text(setupDescProgressOnRubric(value: learningObj.assessments?.first?.score?.rawValue ?? 0))
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
        .modifier(AnimatingCellHeight(height: expand ? 350 : 150))
        .background(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255) : Color.customLightGrey)
        .cornerRadius(14)
        .onTapGesture {
        //    withAnimation {       // TEMPORARY REMOVED BECAUSE OF UI SMALL LEFT RECTANGLE VIEW GLITCHED
                self.expand.toggle()
//            }
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
    
    func setupColor(darkMode: Bool, strand: Strands) -> Color {
        
        return strand.toColor(dark: darkMode)

        
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
