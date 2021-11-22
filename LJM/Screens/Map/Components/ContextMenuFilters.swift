//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 18/10/21.
//

import Foundation
import SwiftUI

struct ContextMenuFilters: View {
    
    var fromMap = false
    var arrayMainFilters = ["Full Map", "Communal", "Elective"]
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var selectedPath : String?
    @Binding var selectedPaths: [String]
    @Binding var selectedStrands : [String]
    @Binding var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    var body: some View {
        Menu {
            Group {
                ForEach(arrayMainFilters, id: \.self) { mainFilter in
                    Button {
                        selectedFilter = mainFilter.uppercased()
                    } label: {
                        HStack {
                            Text(mainFilter)
                            Image(systemName: "checkmark")
                                .isHidden(!(selectedFilter.lowercased() == mainFilter.lowercased()))
                        }
                    }
                }
                
                Divider()
                
                ForEach(self.learningPathsStore.learningPaths, id: \.title) { learningPath in
                    if !fromMap {
                        Button {
//                            if self.fromMap {
//                                selectedFilter = learningPath.title
//                            } else {
                                selectedPath = learningPath.title
//                            }
                            
                        } label: {
                            HStack {
                                Text(learningPath.title)
                                Image(systemName: "checkmark")
                                    .isHidden(!(selectedFilter == learningPath.title || selectedPath == learningPath.title))
                            }
                        }
                    } else {
                        Button {
//                            if self.fromMap {
                               // selectedFilter = learningPath.title
//                            } else {
//                                selectedPath = learningPath.title
//                            }
                            
//                            if !self.selectedStrands.contains(strand) {
//                                self.selectedStrands.append(strand)
//                            } else {
//                                self.selectedStrands.remove(object: strand)
//                            }
                                                        
                            if !self.selectedPaths.contains(learningPath.title) {
                                selectedPaths.append(learningPath.title)
                            } else {
                                selectedPaths.remove(object: learningPath.title)
                            }
                            
                        } label: {
                            HStack {
                                Text(learningPath.title)
                                Image(systemName: "checkmark")
                                    .isHidden(!(selectedFilter == learningPath.title || selectedPath == learningPath.title))
                            }
                        }
                    }
                }
            }
            
            Divider()
            
            Group {
                ForEach(self.strandsStore.arrayStrandsNativeFilter, id: \.self) { strand in
                    Button {
                        if !self.selectedStrands.contains(strand) {
                            self.selectedStrands.append(strand)
                        } else {
                            self.selectedStrands.remove(object: strand)
                        }
                    } label: {
                        HStack {
                            Text(strand)
                            Image(systemName: "checkmark")
                                .isHidden(!self.selectedStrands.contains(strand))
                        }
                    }
                }
                
                Divider()
                
                if fromMap {
                    Button {
                        selectedEvaluatedOrNotFilter = .evaluated
                    } label: {
                        HStack {
                            Text("Evaluated")
                            Image(systemName: "checkmark")
                                .isHidden(!(selectedEvaluatedOrNotFilter == .evaluated))
                        }
                    }
                    
                    Button {
                        selectedEvaluatedOrNotFilter = .notEvaluated
                    } label: {
                        HStack {
                            Text("Not Evaluated")
                            Image(systemName: "checkmark")
                                .isHidden(!(selectedEvaluatedOrNotFilter == .notEvaluated))
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                //                    .resizable()
                //                    .frame(width: 10, height: 10)
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
                
                Text("Filters")
                //                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color(red: 160/255, green: 159/255, blue: 159/255) : Color(red: 87/255, green: 87/255, blue: 87/255))
            }
            
        }
        .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
        .menuStyle(BorderedButtonMenuStyle())
        
    }
    
}


