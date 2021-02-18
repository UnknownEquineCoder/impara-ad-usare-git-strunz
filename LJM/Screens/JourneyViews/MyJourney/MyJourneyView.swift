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
    
    @State private var searchText = ""
    
    @State private var showView = true
    @Environment(\.colorScheme) var colorScheme
    
    var paths = ["Design" : Color.customCyan, "Frontend": Color.orange, "Backend": Color.yellow, "Business": Color.purple]
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                TitleScreenView(title: "My Journey")
                
                DropDownSelectPathView(dictPaths: self.paths, selectedPath: $selectedPath)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 230)
                    .padding(.top, 10)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here you will find your Learning Objectives you choose to work on, that will help you build your own path. Based on the path you choose, the arrows will indicate the recommanded level to reach.")
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.top, 50)
                
                ScrollViewFiltersJourney(filterTabs: arrayFilters, selectedFilter: $selectedFilter).padding(.top, 20).padding(.top, 120)
                
            }.frame(maxWidth: .infinity)
            
            ZStack(alignment: .topLeading) {
                
                NumberTotalLearningOjbectivesView(totalLOs: 50)
                
                TestButtons().padding(.leading, 200)
                
                SearchBarExpandableJourney(txtSearchBar: $searchText).background(colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white)
                    .padding(.trailing, 200)
                    .frame(maxWidth: .infinity,  alignment: .trailing)
                
                DropDownMenuFilters()
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .zIndex(1)
                
                ListViewLearningObjectiveMyJourney(showView: self.$showView, selectedFilter: $selectedFilter, txtSearchBar: $searchText)
                    .padding(.top, 50)
            }.frame(maxWidth: .infinity).padding(.top, 10)
        }.padding(.leading, 50).padding(.trailing, 50)
    }
}

struct TestButtons: View {
    @State private var showView = true
    
    let testLPObject =  LearningPath(title: "Learning Objective Test 3", description: "Learning Objective Test 3 Description", createdByStudent: "Carl", learningObjectives: [LearningObjective(_id: "60250f52c96e69001dbe46d0", tags: ["TEST TAG"], title: "HUBJNHUGY", isCore: true, isElective: true, description: "IJK?JNHUB", createdByLearner: "Guy")])
    
    let testLOObject = LearningObjective(_id: "60250f52c96e69001dbe46d0", tags: ["YEYE", "BOBO"], title: "Learning Objective Test 1", isCore: false, isElective: true, description: "Learning Objective Test Desc 1", createdByLearner: "Bobby")
    
    var body: some View {
        HStack {
            Button(action: {
                self.showView.toggle()
                Webservices.getAllLearningPaths { learningPathResult, err  in
                    print("IJHUGY \(learningPathResult)")
                }
            }) {
                Text("Get")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                
                Webservices.addLearningPath(title: testLPObject.title!, description: testLPObject.description!, learningObjectives: ["60250f52c96e69001dbe46d0", "6028d22accda6a001e119d9c"], createdByLearner: testLPObject.createdByStudent!, completion: { (result, error) in
                    print("yutfguhij \(result)")
                })
                
            }) {
                Text("Add")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                let testLPObject =  LearningPath(_id: "602b4da884f2460029a55f5f", title: "Learning Objective Test 4", description: "Learning Objective Test 4 Description", createdByStudent: "Carl", learningObjectives: [LearningObjective(_id: "60250f52c96e69001dbe46d0", tags: ["TEST TAG 2"], title: "HUBJNHUGY", isCore: true, isElective: true, description: "IJK?JNHUB", createdByLearner: "Guy")])
                
                Webservices.updateLearningPath(id: testLPObject._id!, title: testLPObject.title, description: testLPObject.description, learningObjectives: ["60250f52c96e69001dbe46d0", "6028d22accda6a001e119d9c"], createdByLearner: testLPObject.createdByStudent) { (result, error) in
                    print("JNBHGVBH \(result)")
                }
            }) {
                Text("Update")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                let testLPObject =  LearningPath(_id: "6029df6750c6800028c1de04", title: "Learning Objective Test 4", description: "Learning Objective Test 4 Description", createdByStudent: "Carl", learningObjectives: [LearningObjective(_id: "60250f52c96e69001dbe46d0", tags: ["TEST TAG 2"], title: "HUBJNHUGY", isCore: true, isElective: true, description: "IJK?JNHUB", createdByLearner: "Guy")])
                
                Webservices.deleteLearningPath(id: testLPObject._id!) { (result, error) in
                    print("YUGH \(result)")
                }
            }) {
                Text("Delete")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.getAllLearningObjectives { (learningObjectives, err) in
                    print("YUIY \(learningObjectives)")
                }
            }) {
                Text("Get LOs")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.getLearningObjective(id: "60250f52c96e69001dbe46d0") { (learningObjective, err) in
                    print("UHIYGTU \(learningObjective)")
                }
            }) {
                Text("Get LOs id")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.addLearningObjective(learningObjective: self.testLOObject) { (learningObjective, err) in
                    print("JIHUYGT \(learningObjective)")
                }
            }) {
                Text("Add LOs")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.updateLearningObjective(learningObjective: self.testLOObject) { (learningObjective, err) in
                    print("iuhyiqjeof \(learningObjective)")
                }
            }) {
                Text("Update LO")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                Webservices.deleteLearningObjective(learningObjective: self.testLOObject) { (learningObjective, err) in
                    print("fqefqef \(learningObjective)")
                }
            }) {
                Text("delete LO")
                    .padding()
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(Color.customCyan)
                    .frame(height: 30, alignment: .center)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color.customCyan))
            }.buttonStyle(PlainButtonStyle())
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
    @Environment(\.colorScheme) var colorScheme
    
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
                    .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
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
        .background(colorScheme == .dark ? Color(red: 49/255, green: 44/255, blue: 45/255) : .white)
        //        .border(expand ? Color.customBlack : Color.white)
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
    
    @Binding var showView: Bool
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var txtSearchBar : String
    
    var body: some View {
        
        if showView {
            ScrollViewLearningObjectives(filterCore: selectedFilter, isAddable: false, textFromSearchBar: txtSearchBar)
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
