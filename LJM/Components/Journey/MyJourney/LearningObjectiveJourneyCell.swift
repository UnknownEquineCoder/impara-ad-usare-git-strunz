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
    
    var isAddable = false
    var title: String
    var subtitle: String
    var core: String
    var description: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .topLeading) {
                
                Rectangle()
                    .frame(width: 20, alignment: .leading)
                    .foregroundColor(color)
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title.uppercased()).foregroundColor(color).font(.system(size: 20, weight: .semibold, design: .rounded))
                        Text(subtitle.uppercased()).foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light))
                        Text(core.uppercased()).foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light))
                    }.padding(.leading, 20).padding(.top, 15)
                    
                    Spacer()
                    
                    Text(description).foregroundColor(Color.customLightBlack).font(.system(size: 16, weight: .medium)).padding(.top, 45)
                    
                    Spacer()
                    
                    Divider().background(Color.customBlack).padding(.top, 20).padding(.bottom, 20).padding(.trailing, 20).isHidden(self.isRatingView ? false : true)
                    
                    if !isAddable {
                        RatingView(rating: $rating).padding(.top, 15).padding(.trailing, 30).onAppear(perform: {
                            self.isRatingView.toggle()
                        })
                    } else {
                        AddButton(buttonSize: 27).padding(.trailing, 50).padding(.top, 40)
                    }
                }.padding(.leading, 20)
                
                HStack {
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider().background(Color.customDarkGrey).padding(.trailing, 100)
                            
                            HStack {
                                Text("KEYWORDS").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light))
                                Spacer()
                                Text("#CBL #project management #milestones #project monitoring").foregroundColor(Color.customLightBlack).font(.system(size: 16, weight: .medium))
                                Spacer()
                            }
                            
                            Divider().background(Color.customDarkGrey).padding(.trailing, 100)
                            
                            HStack {
                                Text("HISTORY").foregroundColor(Color.customDarkGrey).font(.system(size: 17, weight: .light))
                                Spacer()
                                ScrollView(.horizontal, showsIndicators: true) {
                                    HStack {
                                        ForEach(0..<2) { item in
                                            HistoryProgressView()
                                        }
                                    }
                                }.frame(width: 430)
                                Spacer()
                            }
                        }.padding(.leading, 40)
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("PROGRESSING")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.customCyan)
                        Text("You can understand and apply concepts with assistance.")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color.customDarkGrey)
                            .multilineTextAlignment(.center)
                    }.frame(width: 150, height: 50, alignment: .center)
                    .padding(.trailing, 38)
                    .isHidden(self.isRatingView ? false : true)
                    
                }.frame(maxWidth: .infinity, maxHeight: self.expand ? 185 : 0, alignment: .topLeading)
                .padding(.trailing, 20)
                .isHidden(self.expand ? false : true)
                .offset(y: 100)
                
                Image(systemName: self.expand ? "chevron.up" : "chevron.down")
                    .foregroundColor(Color.customCyan)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            }
            
        }.modifier(AnimatingCellHeight(height: expand ? 260 : 120))
        .background(Color.customLightGrey)
        .cornerRadius(14)
        .onTapGesture {
            withAnimation {
                self.expand.toggle()
            }
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

struct LearningObjectiveMyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        LearningObjectiveJourneyCell(title: "Design", subtitle: "", core: "", description: "", color: Color.red)
    }
}
