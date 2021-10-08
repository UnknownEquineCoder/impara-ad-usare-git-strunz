//
//  StackNavigationView.swift
//  LJM
//
//  Created by Laura Benetti on 25/03/21.
//

import SwiftUI

struct StackNavigationView<RootContent, SubviewContent>: View where RootContent: View, SubviewContent: View {
    
    @Binding var currentSubviewLabel: String
    @Binding var showingSubview: Bool
    let subviewByLabel: (String) -> SubviewContent
    let rootView: () -> RootContent
   
    
    var body: some View {
        VStack {
            VStack{
                if !showingSubview { // Root view
                    rootView()
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(AnyTransition.move(edge: .leading)).animation(.default)
                }
                if showingSubview { // Correct subview for current index
                    StackNavigationSubview(isVisible: self.$showingSubview) {
                        self.subviewByLabel(self.currentSubviewLabel)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
                }
            }
        }
    }
    
    init(currentSubviewLabel: Binding<String>, showingSubview: Binding<Bool>, @ViewBuilder subviewByLabel: @escaping (String) -> SubviewContent, @ViewBuilder rootView: @escaping () -> RootContent) {
        self._currentSubviewLabel = currentSubviewLabel
        self._showingSubview = showingSubview
        self.subviewByLabel = subviewByLabel
        self.rootView = rootView
    }
    
    private struct StackNavigationSubview<Content>: View where Content: View {
        
        @Environment(\.colorScheme) var colorScheme
        @Binding var isVisible: Bool
        let contentView: () -> Content
        
        var body: some View {
            VStack {
                HStack { // Back button
                    Button(action: {
                        self.isVisible = false
                    }) {
                        HStack{
                            Image(systemName: "chevron.backward").foregroundColor(Color.customCyan)
                                .scaleEffect(CGSize(width: 1.26, height: 1.26))
                            Text("Compass")
                                .foregroundColor(colorScheme == .dark ? Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.9) : Color(red: 70/255, green: 70/255, blue: 70/255))
                                .underline(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, color: Color.customCyan)
                                .font(.system(size: 24.toFontSize()))
                        }.padding(.leading, 20.toScreenSize())
                    }.buttonStyle(BorderlessButtonStyle())
                    Spacer()
                }
                .padding(.horizontal).padding(.vertical, 4)
                // contentView() // Main view content
            }
        }
    }
}


//struct BarGraphNavigationLabel: View {
//
//    @State private var currentSubviewIndex = 0
//    @State private var showingSubview = false
//
//    var color: Color
//    var title: String
//    var skills: [String]
//    var levels: [String] = ["No Exposure", "Beginning", "Progressing", "Proficient", "Exemplary"]
//
//    var body: some View {
//        StackNavigationView(
//            currentSubviewIndex: self.$currentSubviewIndex,
//            showingSubview: self.$showingSubview,
//            subviewByIndex: { index in
//                self.subView(forIndex: index)
//            }
//        ) {
//            GeometryReader { geo in
//                ZStack{
//                    Rectangle().fill(Color.clear)
//                        .border(color)
//                        .frame(width: 1400.toScreenSize(), height: 75 * CGFloat(skills.count))
//                    VStack{
//                        HStack{
//                            Text(title)
//                                .foregroundColor(color)
//                                .font(.system(size: 29.toFontSize()))
//                                .fontWeight(.semibold)
//                            Spacer()
//                        }
//                        .padding(.leading, 49.toScreenSize())
//                        HStack {
//                            Spacer()
//                            HStack(spacing: (geo.size.width*0.66) / 10){
//
//                                ForEach(levels, id: \.self){
//                                    level in
//                                    Text(level)
//                                        .font(.system(size: 16.toFontSize()))
//                                        .fontWeight(.light)
//
//                                }
//
//
//                            }
//                            .frame(width: geo.size.width * 0.66)
//                            .padding(.leading, geo.size.width/20)
//                            .padding(.trailing, 130.toScreenSize())
//
//
//
//                        }
//                        HStack {
//
//                                        VStack(alignment: .leading, spacing: 49.toScreenSize()) {
//                                            ForEach(0..<skills.count, id: \.self) {
//                                                index in
//
//                                                Text(skills[index])
//                                                    .foregroundColor(color)
//                                                    .font(.system(size: 20.toFontSize()))
//                                                    .fontWeight(.light)
//                                                    .underline()
//                                                    .onTapGesture {
//                                                    self.showSubview(withIndex: index)
//                                                }
//                                            }
//                                        }
//                            .padding(.leading, 51.toScreenSize())
//                            Spacer()
//                            VStack(spacing: 51.toScreenSize()){
//                                ForEach(skills, id: \.self){
//                                    skill in
//
//                                    ProgressBarGraph(progress: Double(Int.random(in: 20...100)), color: color)
//                                        .frame(width: geo.size.width * 0.66, height: 16.toScreenSize())
//                                        .padding(.trailing, 116.toScreenSize())
//
//                                }
//                            }
//
//
//                        }
//                        /*
//                         ProgressBarGraph(progress: 45, color: color)
//                         .frame(width: geo.size.width * 0.8, height: 16.toScreenSize())             **/
//                    }
//                    .padding(.top, 30)
//                    .padding(.bottom, 30)
//                }
//            }.frame(width: 1400.toScreenSize(), height: 75 * CGFloat(skills.count))
//
//
//
////
////            VStack(alignment: .leading, spacing: 49.toScreenSize()) {
////                ForEach(0..<categories.count, id: \.self) {
////                    index in
////
////                    Text(categories[index])
////                        .foregroundColor(color)
////                        .font(.system(size: 20.toFontSize()))
////                        .fontWeight(.light)
////                        .underline()
////                        .onTapGesture {
////                        self.showSubview(withIndex: index)
////                    }
////                }
////            }
////            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//    }
//
//    private func subView(forIndex index: Int) -> LearningGoalsView {
//        return LearningGoalsView(titleView: skills[index])
//    }
//
//    private func showSubview(withIndex index: Int) {
//        currentSubviewIndex = index
//        showingSubview = true
//    }
//}


struct StackNavigationView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        EmptyView()
    }
}
