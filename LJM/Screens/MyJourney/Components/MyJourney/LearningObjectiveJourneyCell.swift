import SwiftUI

struct LearningObjectiveJourneyCell: View {
    @State var rating = 0
    @State var expand: Bool = false
    @State var isRatingView: Bool
    var value : Int = 0
    @Environment(\.colorScheme) var colorScheme
    @Binding var filter_Text : String
    
    var isAddable = false
    var isLearningGoalAdded: Bool?
    @Binding var learningPathSelected : String?
    
    @State private var showingAlert = false
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    var learningObj: learning_Objective
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                
                HStack {
                    Spacer()
                    
                    VStack {
                        
                        // it checks what's the dimension of the spaces should be
                        
                        if expand && !isAddable{
                            Spacer().frame(height: 20)
                        } else if self.isLearningGoalAdded == nil{
                            Spacer()
                        } else {
                            if isAddable {
                                Spacer().frame(height: 20)
                            } else {
                                Spacer()
                            }
                        }
                        
                        if self.isLearningGoalAdded != nil {
                            if learningObj.eval_score.count > 0 {
                                RatingView(learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.trailing, 30).padding(.leading, 20)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, rating: $rating, buttonSize: 27).padding(.trailing, 60)
                                    .padding(.bottom, 20)
                            }
                        } else {
                            if !isAddable {
                                RatingView(learningObj: learningObj, rating: $rating, learningPathSelected: self.$learningPathSelected)
                                    .padding(.trailing, 30)
                                    .onAppear(perform: {
                                        self.isRatingView.toggle()
                                    })
                            } else {
                                AddButton(learningObjectiveSelected: learningObj, rating: $rating, buttonSize: 27).padding(.trailing, 60)
                                    .padding(.bottom, 20)
                            }
                        }
                        Spacer()
                    }
                }
                
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: learningObj.strand))
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(learningObj.strand.uppercased())
                                .foregroundColor(setupColor(darkMode: colorScheme == .dark, strand: learningObj.strand))
                                .font(.system(size: learningObj.strand.count > 15 ? 15 : 20, weight: .bold, design: .rounded))
                                .lineLimit(2)
                            Text(learningObj.goal_Short.uppercased())
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .regular))
                                .lineLimit(3)
                            Text(learningObj.isCore ? "CORE" : "ELECTIVE")
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey)
                                .font(.system(size: 22.toFontSize(), weight: .light))
                                .lineLimit(2)
                        }
                        .frame(width: 150, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        
                        Spacer().frame(width: 50)
                        
                        Text("\(learningObj.ID) - \(learningObj.description)")
                            .foregroundColor(colorScheme == .dark ? Color(red: 224/255, green: 224/255, blue: 224/255) : Color.customLightBlack)
                            .font(.system(size: 24.toFontSize(), weight: .regular))
                            .padding(.trailing, 30)
                            .lineLimit(self.expand ? nil : 4)
                            .padding()
                            .padding(.trailing, 20)
                        
                        Spacer().frame(width: 230)
                        
                    }
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.trailing, 60)
                            
                            HStack {
                                Text("KEYWORDS").foregroundColor(Color.customDarkGrey)
                                    .font(.system(size: 17, weight: .light))
                                    .frame(width: 170, alignment: .leading)
                                
                                Spacer().frame(width: 50)
                                
                                GeometryReader { geometry in
                                    generateContent(in: geometry)
                                }
                                .frame( height: learningObj.Keyword.count > 6 ? 105 : 50)
                                .foregroundColor(Color.customLightBlack)
                                .font(.system(size: 16, weight: .medium))
//                                .padding(.leading, 10)
                                .padding(.trailing, 50)
                                
                                Spacer()
                            }
                            //comment for update
                            Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.trailing, 60)
                            
                            HStack {
                                Text("LAST ASSESSMENTS").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light)).frame(width: 170, alignment: .leading)
                                Spacer().frame(width: 50)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        if learningObj.eval_score.isEmpty {
                                            Text("This Learning Objective has never been assessed...")
                                                .foregroundColor(Color.customDarkGrey)
                                                .font(.system(size: 17, weight: .light))
                                        }
                                        ForEach(learningObj.eval_score.indices, id: \.self) { index in
                                            HistoryProgressView(rating: $rating, learning_Score: learningObj.eval_score[index], learning_Date: learningObj.eval_date[index], learning_ID: learningObj.ID, index: index)
                                            
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
                    Spacer().frame(height: 300)
                    Text(setupTitleProgressRubric(value: learningObj.eval_score.last ?? 0))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.customCyan)
                    Text(setupDescProgressOnRubric(value: learningObj.eval_score.last ?? 0))
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.customDarkGrey)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 200)
                    
                    
                    Spacer().frame(height: 50)
                    
                    VStack {
                        if #available(macOS 12.0, *) {
                            Button(action: {
                                showingAlert = true
                            }) {
                                Image(systemName: "trash")
                                    .renderingMode(.original)
                                    .foregroundColor(Color.red)
                                    .isHidden(!(learningObj.eval_score.count > 0))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .cursor(.pointingHand)
                            .alert("Are you sure you want to delete this Learning Objective ?", isPresented: $showingAlert) {
                                Button("No", role: .cancel) {
                                    
                                }
                                
                                Button("Yes", role: .cancel) {
                                    let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
                                    learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)                            }
                            }
                        } else {
                            // Fallback on earlier versions
                            Button(action: {
                                let learningObjectiveIndex = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == learningObj.ID})!
                                learningObjectiveStore.remove_Evaluation(index: learningObjectiveIndex)  
                            }) {
                                Image(systemName: "trash")
                                    .renderingMode(.original)
                                    .foregroundColor(Color.red)
                                    .isHidden(!(learningObj.eval_score.count > 0))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .cursor(.pointingHand)
                        }
                    }
                }.frame(width: 260, height: 100, alignment: .center)
                    .isHidden(self.isAddable ? true : false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .isHidden(self.expand ? false : true)
                
                HStack {
                    Divider()
                        .background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.top, 20).padding(.bottom, 20).padding(.trailing, 250)
                        .padding(.trailing, !isAddable ? 25 : 0)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .zIndex(1)
                
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.customCyan)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
                    .cursor(.pointingHand)
            }
            
        }
        .background(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255) : Color(red: 230/255, green: 230/255, blue: 230/255))
        .cornerRadius(14)
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
        }
        .contextMenu {
            if learningObj.eval_score.count > 0 {
                Button {
                    self.showingAlert = true
                } label: {
                    Text("Delete")
                }
            }
                
                
            
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(learningObj.Keyword, id: \.self) { keyword in
                Text("#\(keyword.replacingOccurrences(of: " ", with: "")) ")
                    .onTapGesture {
                        withAnimation {
                            filter_Text = keyword
                        }
                        
                    }
                    .onLongPressGesture {
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(keyword, forType: .string)
                    }
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if keyword == learningObj.Keyword.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if keyword == learningObj.Keyword.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
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
