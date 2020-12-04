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
    let arrayFilters = ["All", "Core", "Elective", "Evaluated"]
    
    @State private var showTest = true
    
    var paths = ["Design" : Color.customCyan, "Frontend": Color.orange, "Backend": Color.yellow, "Business": Color.purple]
    
    var body: some View {
        VStack {
            VStack( spacing: 0) {
                ZStack(alignment: .top) {
                    Text("My Journey")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.customBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DropDownSelectPathView(dictPaths: self.paths, selectedPath: $selectedPath)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 150)
                        .zIndex(1)
                    
                    VStack(alignment: .leading) {
                        Text("Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                            .foregroundColor(Color.customLightGray)
                            .padding(.top, 20)
                            .padding(.trailing, 90)
                        
                        Rectangle().frame(height: 1).foregroundColor(Color.customLightGray)
                    }.padding(.top, 50)
                    
                    ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter).padding(.top, 20).padding(.top, 130)
                    
                }.frame(maxWidth: .infinity)
                
                HStack {
                    Text("Number of objectives :")
                        .foregroundColor(Color.customGrey)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding(.leading, 20)
                    
                    Spacer()
                    
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
                    
                    Spacer()
                    
                    FilterButtonJourney()
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                }.padding(.top, 20)
                
                Spacer()
                
                ListViewLearningObjectiveMyJourney(show: self.$showTest)
                
            }
        }
    }
}

struct DropDownSelectPathView: View {
    @State var expand = false
    @State var dictPaths = [String: Color]()
    @Binding var selectedPath : String
    @State var colorSelectedPath = Color.gray
    
    var body: some View {
        
        let keys = dictPaths.map{$0.key}
        let values = dictPaths.map{$0.value}
        
        VStack {
            HStack {
                Text(self.selectedPath)
                    .frame(width: 150, height: 30, alignment: .center)
                    .foregroundColor(colorSelectedPath)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
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
                            self.colorSelectedPath = values[i]
                            self.expand.toggle()
                        }) {
                            Text(keys[i])
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(self.selectedPath == keys[i] ? .customLightBlack : .customLightGray)
                                .frame(width: 150, height: 30)
                                .background(Color.white)
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
    let addObjText = "Add a learning objective"
    
    var body: some View {
        
        if show {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach (0..<5) { status in
                        LearningObjectiveMyJourneyView()
                            .background(Color.white)
                    }
                }
            }
        } else {
            ZStack {
                BackgroundImageReadingStudent()
                
                VStack {
                    Text("The Learning Objective is half the journey !")
                        .font(.system(size: 45, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.customBlack)
                    
                    Text("Tap the button to add the first one.")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.customGrey)
                        .padding(.top, 20)
                    
                    Button(action: {
                        
                    }) {
                        Text(addObjText.uppercased())
                            .padding()
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(Color.customCyan)
                            .frame(width: 250, height: 50, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
                            .background(Color.white)

                    }.buttonStyle(PlainButtonStyle())
                    .padding(.top, 20)
                }
            }
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
