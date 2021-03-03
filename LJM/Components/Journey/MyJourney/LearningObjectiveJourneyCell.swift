//
//  LearningObjectiveMyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 27/11/2020.
//

import SwiftUI

struct LearningObjectiveJourneyCell: View {
    @State var rating = 0
    @State var expand: Bool = false
    @State var isRatingView: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var isAddable = false
    var learningObjective: LearningObjective
    
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .topLeading) {
                
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .foregroundColor(setupColor())
                
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(learningObjective.strand?.uppercased() ?? "No strand").foregroundColor(setupColor()).font(.system(size: 20, weight: .semibold, design: .rounded))
                            Text(learningObjective.title?.uppercased() ?? "No title").foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey).font(.system(size: 22.toFontSize(), weight: .light))
                            Text(learningObjective.isCore ?? true ? "Core" : "Elective").foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color.customDarkGrey).font(.system(size: 22.toFontSize(), weight: .light))
                        }.frame(width: 150, alignment: .leading).padding(.leading, 20).padding(.top, 15)
                        
                        Spacer()
                        
                        Text(learningObjective.description ?? "No description").foregroundColor(colorScheme == .dark ? Color(red: 224/255, green: 224/255, blue: 224/255) : Color.customLightBlack).font(.system(size: 24.toFontSize(), weight: .regular)).frame(maxWidth: 639.toScreenSize(), maxHeight: .infinity, alignment: .center).lineLimit(self.expand ? nil : 4).padding()
                        
                        Spacer()
                        
                        if !isAddable {
                            RatingView(goalRating: learningObjective.coreRubricLevel, rating: $rating).padding(.top, 15).padding(.trailing, 30).onAppear(perform: {
                                self.isRatingView.toggle()
                            })
                        } else {
                            AddButton(buttonSize: 27).padding(.trailing, 32).padding(.top, 24)
                        }
                        
                    }.padding(.leading, 20)
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.trailing, 60)
                            
                            HStack {
                                Text("KEYWORDS").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light)).frame(width: 150, alignment: .leading)
                                Spacer()
                                
                                Text("#\(learningObjective.tags?.joined(separator: " #") ?? "")")
                                    .foregroundColor(Color.customLightBlack)
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .padding()
                                
                                Spacer()
                            }
                            
                            Divider().background(Color.customDarkGrey).padding(.trailing, 60)
                            
                            HStack {
                                Text("HISTORY").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light)).frame(width: 150, alignment: .leading)
                                Spacer()
                                ScrollView(.horizontal, showsIndicators: true) {
                                    HStack(spacing: 10) {
                                        ForEach(0..<2) { item in
                                            HistoryProgressView()
                                        }
                                    }
                                }.frame(width: 430)
                                Spacer()
                            }
                        }.padding(.leading, 40).padding(.bottom, 50)
                        
                    }.frame(maxWidth: 1402.toScreenSize(), maxHeight: self.expand ? 185 : 0, alignment: .topLeading)
                    .padding(.trailing, 250)
                    .isHidden(self.expand ? false : true)
                }
                
                VStack(alignment: .center, spacing: 5) {
                    Spacer().frame(height: 200)
                    Text("PROGRESSING")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.customCyan)
                    Text("You can understand and apply concepts with assistance.")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color.customDarkGrey)
                        .multilineTextAlignment(.center)
                }.frame(width: 150, height: 50, alignment: .center)
                .padding(.trailing, 54)
                .isHidden(self.isRatingView ? false : true)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .isHidden(self.expand ? false : true)
                
                HStack {
                    Divider().background(Color(red: 70/255, green: 70/255, blue: 70/255)).padding(.top, 20).padding(.bottom, 20).padding(.trailing, 250).isHidden(self.isRatingView ? false : true)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .zIndex(1)
                
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.customCyan)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            }
        }
        .modifier(AnimatingCellHeight(height: expand ? 400 : 120))
        .background(colorScheme == .dark ? Color(red: 50/255, green: 50/255, blue: 50/255) : Color.customLightGrey)
        .cornerRadius(14)
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
        }
    }
    
    func setupColor() -> Color {
        var colorPath : Color = Color.red
        
        for learningPath in learningPathsStore.learningPaths {
            if learningPath.learningObjectives != nil {
                for learningObjectiveFromPath in learningPath.learningObjectives! {
                    if learningObjectiveFromPath.id == self.learningObjective.id {
                        colorPath = Color.init(red: learningPath.pathColor.red, green: learningPath.pathColor.green, blue: learningPath.pathColor.blue)
                    }
                }
            }
        }
        
        return colorPath
    
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
