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
                        Text(title.uppercased()).foregroundColor(color).font(.system(size: 15, weight: .semibold, design: .rounded))
                        Text(subtitle.uppercased()).foregroundColor(Color.customBlack)
                        Text(core.uppercased()).foregroundColor(Color.customBlack)
                    }.padding(.leading, 20).padding(.top, 15)
                    
                    Spacer()
                    
                    Text(description).foregroundColor(Color.customBlack).padding(.top, 45)
                    
                    Spacer()
                    
                    Divider().background(Color.customBlack).padding(.top, 20).padding(.bottom, 20).padding(.trailing, 20)
                    
                    if !isAddable {
                        RatingView(rating: $rating).padding(.top, 15)
                    } else {
                        AddButton(buttonSize: 27).padding(.trailing, 50).padding(.top, 40)
                    }
                }.padding(.leading, 20)
                
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Divider().background(Color.customDarkGrey)
                        
                        HStack {
                            Text("KEYWORDS").foregroundColor(Color.customBlack)
                            Spacer()
                            Text("#CBL #project management #milestones #project monitoring").foregroundColor(Color.customBlack)
                            Spacer()
                        }
                        
                        Divider().background(Color.customDarkGrey)
                        
                        HStack {
                            Text("HISTORY").foregroundColor(Color.customBlack)
                            Spacer()
                            Text("HISTORY VIEWS").foregroundColor(Color.customBlack)
                            Spacer()
                        }
                    }.padding(.leading, 40).padding(.trailing, 280)
                }
                .frame(maxWidth: .infinity, maxHeight: self.expand ? 185 : 0, alignment: .topLeading)
                .padding(.trailing, 20)
                .isHidden(self.expand ? false : true)
                .offset(y: 100)
                
                Image(systemName: self.expand ? "arrow.down.to.line" : "arrow.up.to.line")
                    .foregroundColor(Color.customCyan)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            }
            
        }.modifier(AnimatingCellHeight(height: expand ? 300 : 100))
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
