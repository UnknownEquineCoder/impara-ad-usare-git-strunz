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
    
    @State private var showTest = true
    
    var paths = ["Design" : Color("customCyan"), "Frontend": Color.orange, "Backend": Color.yellow, "Business": Color.purple]
    
    var body: some View {
        VStack {
            VStack( spacing: 0) {
                ZStack(alignment: .top) {
                    Text("My Journey")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DropDownSelectPathView(dictPaths: self.paths, selectedPath: $selectedPath)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 150)
                        .zIndex(1)
                    
                    VStack(alignment: .leading) {
                        Text("Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                            .foregroundColor(Color.gray)
                            .padding(.top, 20)
                            .padding(.trailing, 90)
                        
                        Rectangle().frame(height: 1).foregroundColor(Color.gray)
                    }.padding(.top, 50)
                    
                    ScrollViewFilters(selectedFilter: $selectedFilter).padding(.top, 20).padding(.top, 130)
                    
                }.frame(maxWidth: .infinity)
                
                HStack {
                    
                    Text("Number of objectives :")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showTest.toggle()
                    }) {
                        Text("Clean objectives")
                            .padding()
                            .font(.system(size: 15, weight: .medium, design: .rounded))         // TEST BUTTON EMPTY OBJECTIVES
                            .foregroundColor(Color("customCyan"))
                            .frame(width: 200, height: 30, alignment: .center)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Filters")
                            .padding()
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color("customCyan"))
                            .frame(width: 130, height: 30, alignment: .center)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
                        
                    }.buttonStyle(PlainButtonStyle())
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
                    .foregroundColor(Color("customCyan"))
                
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
                                .foregroundColor(self.selectedPath == keys[i] ? .black : .gray)
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
        .border(expand ? Color.black : Color.white)
    }
}

struct ScrollViewFilters: View {
    @State var filterTabs = ["All", "Core", "Elective", "Evaluated"]
    @Binding var selectedFilter : String
    
    @StateObject var vm = ScrollToModel()
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    vm.direction = .left
                }
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("customCyan"))
            }.buttonStyle(PlainButtonStyle())
            .opacity(filterTabs.count > 8 ? 1 : 0)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    LazyHStack {
                        HStack(spacing: 10) {
                            ForEach(filterTabs, id: \.self) { i in
                                
                                Button(action: {
                                    self.selectedFilter = i
                                }) {
                                    Text(i.capitalized)
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
                                        .frame(width: 150, height: 40)
                                        .background(self.selectedFilter == i ? Color("customCyan") : .white)
                                }.buttonStyle(PlainButtonStyle())
                                .frame(width: 150, height: 40)
                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
                            }
                        }.padding([.leading, .trailing], 10)
                    }.onReceive(vm.$direction) { action in
                        guard !filterTabs.isEmpty else { return }
                        withAnimation {
                            switch action {
                            case .left:
                                proxy.scrollTo(filterTabs.first!, anchor: .leading)
                            case .right:
                                proxy.scrollTo(filterTabs.last!, anchor: .trailing)
                            default:
                                return
                            }
                        }
                    }.frame(height: 60)
                    .padding(.top, 5).padding(.bottom, 5)
                }
            }.offset(x: filterTabs.count < 8 ? -35 : 0)
            
            Button(action: {
                withAnimation {
                    vm.direction = .right
                }
            }) {
                Image(systemName: "arrow.right")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("customCyan"))
            }.buttonStyle(PlainButtonStyle())
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
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                
                VStack {
                    Text("The Learning Objective is half the journey !")
                        .font(.system(size: 45, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                    
                    Text("Tap the button to add the first one.")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.gray)
                        .padding(.top, 20)
                    
                    Button(action: {
                        
                    }) {
                        Text(addObjText.uppercased())
                            .padding()
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(Color("customCyan"))
                            .frame(width: 250, height: 50, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
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
