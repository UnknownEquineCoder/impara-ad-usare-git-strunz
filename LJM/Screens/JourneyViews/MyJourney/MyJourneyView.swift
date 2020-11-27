//
//  MyJourneyView.swift
//  LJM
//
//  Created by Tony Tresgots on 25/11/2020.
//

import SwiftUI

struct MyJourneyView: View, LJMView {
    @State var selectedPath = "Select your path"
    @State var selectedFilter = "All"
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("My Journey")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .frame(alignment: .topLeading)
                        .overlay(DropDownSelectPathView(selectedPath: $selectedPath).padding(.top, 5).padding(.leading, 350))
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text("EXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLEEXEMPLE EXEMPLE")
                        .foregroundColor(Color.gray)
                        .padding(.top, 20)
                        .padding(.trailing, 90)
                    
                    Rectangle().frame(height: 1).foregroundColor(Color.gray)
                }
                
                ScrollViewFilters(selectedFilter: $selectedFilter).padding(.top, 20)
                
                HStack {
                    
                    Text("Number of objectives :")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Filters")
                            .padding()
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color("customCyan"))
                            .frame(width: 130, height: 30, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
                        
                    }.buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                }.padding(.top, 40)
                
                ListViewLearningObjectiveMyJourney()
                
                Spacer()
            }
        }
    }
}

struct DropDownSelectPathView: View {
    @State var expand = false
    @State var paths = ["Design", "Frontend", "Backend", "Business"]
    @Binding var selectedPath : String
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(self.selectedPath)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .padding(.leading, 10)
                Image(systemName: expand ? "chevron.up.circle" : "chevron.down.circle")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color("customCyan"))
                
            }.onTapGesture {
                self.selectedPath = "Select your path"
                self.expand.toggle()
            }
            
            if expand {
                ForEach(paths, id: \.self) { i in
                    VStack {
                        Button(action: {
                            self.selectedPath = i
                            self.expand.toggle()
                        }) {
                            Text(i)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(self.selectedPath == i ? .black : .gray)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .frame(width: 200, height: expand ? 175 : 40, alignment: .leading)
        .padding(5)
        .cornerRadius(20)
        .animation(.spring())
        .background(Color.white)
    }
}

struct ScrollViewFilters: View {
    @State var filterTabs = ["All", "Core", "Elective", "Evaluated","All1", "Core1", "Elective1", "Evaluated1","All2", "Core2", "Elective2", "Evaluated2","All3", "Core3", "Elective3", "Evaluated3"]
    @Binding var selectedFilter : String
    @State private var scrollTarget: Int?
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    HStack {
                        HStack(spacing: 10) {
                            ForEach(filterTabs, id: \.self) { i in
                                
                                Button(action: {
                                    self.selectedFilter = i
                                }) {
                                    Text(i.capitalized)
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
                                }.buttonStyle(PlainButtonStyle())
                                .frame(width: 150, height: 40)
                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
                            }
                        }.padding(.leading, 50)
                        .padding(.trailing, 50)
                        
                    }.padding(.top, 5).padding(.bottom, 5)
                    .onChange(of: scrollTarget) { target in
                        if let target = target {
                            scrollTarget = nil
                            
                            withAnimation {
                                proxy.scrollTo(target, anchor: .center)
                            }
                        }
                    }
                }

            }

            Button(action: {
                withAnimation {
                    scrollTarget = 10
                }
            }) {
                Text(">")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    var body: some View {
        List {
            LearningObjectiveMyJourneyView()
            LearningObjectiveMyJourneyView()
            LearningObjectiveMyJourneyView()
            LearningObjectiveMyJourneyView()
        }
    }
}

struct MyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyView()
    }
}
