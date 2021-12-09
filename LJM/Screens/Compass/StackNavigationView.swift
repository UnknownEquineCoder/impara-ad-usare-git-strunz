//
//  StackNavigationView.swift
//  LJM
//
//  Created by Laura Benetti on 25/03/21.
//

import SwiftUI

struct StackNavigationView<RootContent, SubviewContent>: View where RootContent: View, SubviewContent: View {
    
    @Environment(\.colorScheme) var colorScheme
    
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
                       // .transition(AnyTransition.move(edge: .leading)).animation(.default)
                }
                if showingSubview { // Correct subview for current index
                    StackNavigationSubview(isVisible: self.$showingSubview) {
                        self.subviewByLabel(self.currentSubviewLabel)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                  // .transition(AnyTransition.move(edge: .trailing)).animation(.default)
                }
            }
        }.background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : Color(red: 245/255, green: 245/255, blue: 245/255))
        
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
                        HStack {
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
                 contentView() // Main view content
                
            }.padding(.top, 10)
        }
    }
}

struct StackNavigationView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        EmptyView()
    }
}
