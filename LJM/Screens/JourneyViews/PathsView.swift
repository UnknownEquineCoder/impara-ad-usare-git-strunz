//
//  PathsView.swift
//  LJM
//
//  Created by Laura Benetti on 28/11/2020.
//

import SwiftUI

struct PathsView: View, LJMView {
    @State var selectedFilter = "All"
    @State var expand: Bool = false

    var filterTabsPath = ["FRONT-END", "BACK-END","BUSINESS", "UI/UX", "GAME"]
    var filterTabsMap = ["FULL MAP", "COMMUNAL"]
    
    @ObservedObject var totalLOs = TotalNumberLearningObjectives()
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    TitleScreenView(title: "Map")

                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    DescriptionTitleScreenView(desc: "Here’s the heart of the Academy: a library of Learning Objectives you can explore and make yours.")
                }
                
                HStack {
                    Text("Map")
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 20))
//                        .padding(.top, 10)
                    ScrollViewFilters(filterTabs: self.filterTabsMap, selectedFilter: $selectedFilter, vm: ScrollToModel())
//                            .padding(.top, 20)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .padding(.leading, 10)
                }
                
                HStack{
    
                    Text("Paths")
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 20))
//                        .padding(.top, 10)
               //     ScrollViewFiltersPaths(selectedFilter: $selectedFilter).padding(.top, 20)
               //         .font(.system(size: 15, weight: .medium, design: .rounded))

                    ScrollViewFilters(filterTabs: self.filterTabsPath, selectedFilter: $selectedFilter, vm: ScrollToModel())
//                            .padding(.top, 20)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                }
                
                ZStack(alignment: .topLeading) {
                    
                    NumberTotalLearningOjbectivesView(totalLOs: 70)
                    
                    DropDownMenuFilters().padding(.trailing, 20).frame(maxWidth: .infinity, alignment: .trailing).zIndex(1)
                    
                    //                    Button(action: {
                    //                        self.expand.toggle()
                    //                    }) {
                    //                        HStack{
                    //                            Image(systemName: "chevron.down")
                    //                                .resizable()
                    //                                .foregroundColor(Color("customCyan"))
                    //                                .frame(width: 10, height: 5, alignment: .center)
                    ////                                .padding()
                    //                            Text("Filters")
                    //                                .padding()
                    //                                .font(.system(size: 15, weight: .medium, design: .rounded))
                    //                                .foregroundColor(Color("customCyan"))
                    //
                    //                        }.frame(width: 130, height: 30, alignment: .center)
                    //                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).foregroundColor(Color("customCyan")))
                    //                    }.buttonStyle(PlainButtonStyle())
                    //                    .padding(.trailing, 20)
                    //                }.padding(.top, 20)
                    ScrollViewLearningObjectives(totalLOs: totalLOs, isAddable: true, textFromSearchBar: "").padding(.top, 70)
                }.frame(minWidth: 0, idealWidth: 1000, maxWidth: .infinity,
                        maxHeight: .infinity, alignment: .leading)
                
                Spacer()
                }
            }.padding(.leading, 50).padding(.trailing, 50)
        }
    
    }


//struct ScrollViewFiltersPaths: View {
//    @State var filterTabs = ["FRONT-END", "BACK-END","BUSINESS", "UI/UX", "GAME"]
//    @Binding var selectedFilter : String
//
//    @StateObject var vm = ScrollToModel()
//
//    var body: some View {
//        HStack {
//
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                ScrollViewReader { (proxy: ScrollViewProxy) in
//                    LazyHStack {
//                        HStack(spacing: 10) {
//                            ForEach(filterTabs, id: \.self) { i in
//
//                                Button(action: {
//                                    self.selectedFilter = i
//                                }) {
//                                    Text(i)
//                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
//                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
//                                }.buttonStyle(PlainButtonStyle())
//                                .frame(width: 150, height: 40)
//                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
//                                .cornerRadius(12)
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
//                            }
//                        }.padding([.leading, .trailing], 10)
//                    }.onReceive(vm.$direction) { action in
//                        guard !filterTabs.isEmpty else { return }
//                        withAnimation {
//                            switch action {
//                            case .left:
//                                proxy.scrollTo(filterTabs.first!, anchor: .leading)
//                            case .right:
//                                proxy.scrollTo(filterTabs.last!, anchor: .trailing)
//                            default:
//                                return
//                            }
//                        }
//                    }.frame(height: 60)
//                    .padding(.top, 5).padding(.bottom, 5)
//                }
//            }
//
//        }
//    }
//}
//
//struct ScrollViewFiltersMap: View {
//    @State var filterTabs = ["FULL MAP", "COMMUNAL"]
//    @Binding var selectedFilter : String
//
//    @StateObject var vm = ScrollToModel()
//
//    var body: some View {
//        HStack {
//
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                ScrollViewReader { (proxy: ScrollViewProxy) in
//                    LazyHStack {
//                        HStack(spacing: 10) {
//                            ForEach(filterTabs, id: \.self) { i in
//
//                                Button(action: {
//                                    self.selectedFilter = i
//                                }) {
//                                    Text(i)
//                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
//                                        .foregroundColor(self.selectedFilter == i ? .white : .gray)
//                                }.buttonStyle(PlainButtonStyle())
//                                .frame(width: 150, height: 40)
//                                .background(self.selectedFilter == i ? Color("customCyan") : .white)
//                                .cornerRadius(12)
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).foregroundColor(self.selectedFilter == i ? .clear : .gray))
//                            }
//                        }.padding([.leading, .trailing], 10)
//                    }.onReceive(vm.$direction) { action in
//                        guard !filterTabs.isEmpty else { return }
//                        withAnimation {
//                            switch action {
//                            case .left:
//                                proxy.scrollTo(filterTabs.first!, anchor: .leading)
//                            case .right:
//                                proxy.scrollTo(filterTabs.last!, anchor: .trailing)
//                            default:
//                                return
//                            }
//                        }
//                    }.frame(height: 60)
//                    .padding(.top, 5).padding(.bottom, 5)
//                }
//            }
//        }
//    }
//}



class ScrollToModel2: ObservableObject {
    enum Action {
        case left
        case right
    }
    @Published var direction: Action? = nil
}

struct PathsView_Previews: PreviewProvider {
    static var previews: some View {
        PathsView()
    }
}

