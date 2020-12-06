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
    @State var selectedFilterInsideButton = "All"
    let arrayFilters = ["All", "Core", "Elective", "Evaluated"]
    
    @State private var showTest = true
    
    var paths = ["Design" : Color.customCyan, "Frontend": Color.orange, "Backend": Color.yellow, "Business": Color.purple]
    
    var body: some View {
        VStack {
            VStack( spacing: 0) {
                ZStack(alignment: .top) {
                    Text("My Journey")
                        .font(.system(size: 40, weight: .medium))
                        .fontWeight(.medium)
                        .foregroundColor(Color.customBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DropDownSelectPathView(dictPaths: self.paths, selectedPath: $selectedPath)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 230)
                        .padding(.top, 10)
                        .zIndex(1)
                    
                    VStack(alignment: .leading) {
                        Text("Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                            .foregroundColor(Color.customDarkGrey)
                            .padding(.top, 20)
                            .padding(.trailing, 90)
                        
                        Rectangle().frame(height: 1).foregroundColor(Color.customDarkGrey)
                    }.padding(.top, 50)
                    
                    ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter).padding(.top, 20).padding(.top, 130)
                    
                }.frame(maxWidth: .infinity)
                
                ZStack(alignment: .top) {
                    Text("Number of objectives :")
                        .foregroundColor(Color.customDarkGrey)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        self.showTest.toggle()
                    }) {
                        Text("Clean objectives test button")
                            .padding()
                            .font(.system(size: 15, weight: .medium, design: .rounded))         // TEST BUTTON EMPTY OBJECTIVES
                            .foregroundColor(Color.customCyan)
                            .frame(width: 200, height: 30, alignment: .center)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
                    }.buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 230)
                    
                    DropDownMenuFilters()
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 1000)
                        .zIndex(1)
                    
                    ListViewLearningObjectiveMyJourney(show: self.$showTest)
                        .padding(.top, 50)
                }.frame(maxWidth: .infinity).padding(.top, 30)
            }
        }
    }
}

struct DropDownSelectPathView: View {
    @State var expand = false
    @State var dictPaths = [String: Color]()
    @Binding var selectedPath : String
    @State var selectedPath2 : String?
    @State var colorSelectedPath = Color.gray
    @State var colorSelectedPath2 : Color?
    
    var body: some View {
        
        let keys = dictPaths.map{$0.key}
        let values = dictPaths.map{$0.value}
        
        VStack {
            HStack {
                Text(self.selectedPath)
                    .frame(width: 150, height: 30, alignment: .center)
                    .foregroundColor(colorSelectedPath)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.leading, 10)
                    .background(Color.white)
                Image(systemName: expand ? "chevron.up.circle" : "chevron.down.circle")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color.customCyan)
                
            }.onTapGesture {
                self.selectedPath = "Select your path"
                self.colorSelectedPath = Color.gray
                self.expand.toggle()
            }
            
            if expand {
                ForEach(keys.indices, id: \.self) { i in
                    VStack {
                        Button(action: {
                            self.selectedPath = keys[i]
                            self.selectedPath2 = keys[i]
                            self.colorSelectedPath = values[i]
                            self.colorSelectedPath2 = values[i]
                            self.expand.toggle()
                        }) {
                            HStack {
                                Text(keys[i])
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(keys[i] == self.selectedPath2 ? colorSelectedPath2 : Color.gray)
                                    .frame(width: 150, height: 30)
                                    .offset(x: selectedPath2 == nil ? 12 : 0)
                                
                                Button(action: {
                                    self.selectedPath = "Select your path"
                                    self.selectedPath2 = nil
                                    self.colorSelectedPath2 = nil
                                    self.expand.toggle()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }.buttonStyle(PlainButtonStyle())
                                .isHidden(keys[i] == self.selectedPath2 ? false : true)
                                .foregroundColor(Color.black)
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .frame(height: expand ? 175 : 30, alignment: .top)
        .padding(5)
        .cornerRadius(20)
        .animation(.spring())
        .background(Color.white)
        .border(expand ? Color.customBlack : Color.white)
    }
}

struct ScrollViewFiltersJourney: View {
    var filterTabs : [String]
    @Binding var selectedFilter : String
    @StateObject var vm = ScrollToModel()
    
    var body: some View {
        HStack {
            ArrowButtonScrollView(vm: vm, direction: .left)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0)
            
            ScrollViewFilters(filterTabs: filterTabs, selectedFilter: $selectedFilter, vm: vm).offset(x: filterTabs.count < 8 ? -35 : 0)
            
            ArrowButtonScrollView(vm: vm, direction: .right)
                .buttonStyle(PlainButtonStyle())
                .opacity(filterTabs.count > 8 ? 1 : 0)
        }
    }
}

struct ListViewLearningObjectiveMyJourney: View {
    
    @Binding var show: Bool
    
    var body: some View {
        
        if show {
            ScrollViewLearningObjectives()
        } else {
            EmptyLearningObjectiveViewJourney()
        }
    }
}

class ScrollToModel: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}

struct MyJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        MyJourneyView()
    }
}
