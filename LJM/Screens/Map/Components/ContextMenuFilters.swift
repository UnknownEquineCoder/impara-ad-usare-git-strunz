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
    var fromCompass = false
    var arrayMainFilters = ["All", "Core", "Elective"]
    
    @Binding var isUpdated : Bool
    
    @Binding var selectedFilter: CoreEnum.RawValue
    @Binding var selectedPath : String?
    @Binding var selectedStrands : [String]
    @Binding var selectedEvaluatedOrNotFilter: EvaluatedOrNotEnum?
    
    @EnvironmentObject var strandsStore: StrandsStore
    @EnvironmentObject var learningPathsStore: LearningPathStore
    
    var body: some View {
        Menu {
            Group {
                
                ForEach(arrayMainFilters, id: \.self) { mainFilter in
                    if mainFilter == arrayMainFilters.first {
                        Button {
                            
                            selectedPath = nil
                            selectedStrands = []
                            selectedEvaluatedOrNotFilter = nil
                            selectedFilter = mainFilter.uppercased()
                            
                            isUpdated.toggle()
                            
                            
                        } label: {
                            HStack {
                                Text(mainFilter)
                                Image(systemName: "checkmark")
                                    .isHidden((!(selectedFilter.lowercased() == "all") || ((selectedPath != nil) || (selectedStrands != []) || (selectedEvaluatedOrNotFilter != nil))))
                            }
                        }
                        
                        Divider()
                    } else {
                        Button {
                            selectedFilter = mainFilter.uppercased()
                            isUpdated.toggle()
                            
                        } label: {
                            HStack {
                                Text(mainFilter)
                                Image(systemName: "checkmark")
                                    .isHidden(!(selectedFilter.lowercased() == mainFilter.lowercased()))
                            }
                        }
                    }
                }
                
                Divider()
                
                ForEach(self.strandsStore.arrayStrandsNativeFilter, id: \.self) { strand in
                    Button {
                        if !self.selectedStrands.contains(strand) {
                            self.selectedStrands.append(strand)
                        } else {
                            self.selectedStrands.remove(object: strand)
                        }
                        
                        isUpdated.toggle()
                        
                    } label: {
                        HStack {
                            Text(strand)
                            Image(systemName: "checkmark")
                                .isHidden(!self.selectedStrands.contains(strand))
                        }
                    }
                }
            }
            
            Divider()
            
            Group {
                
                ForEach(self.learningPathsStore.learningPaths.filter({$0.title != "None"}), id: \.title) { learningPath in
                        Button {
                            selectedPath = selectedPath == learningPath.title ? nil : learningPath.title
                            isUpdated.toggle()
                            
                        } label: {
                            HStack {
                                Text(learningPath.title)
                                Image(systemName: "checkmark")
                                    .isHidden(!(selectedFilter == learningPath.title || selectedPath == learningPath.title))
                            }
                        }
                }
                
                
                
                Divider()
                
                if fromMap || fromCompass {
                    Button {
                        selectedEvaluatedOrNotFilter = selectedEvaluatedOrNotFilter == .evaluated ? nil : .evaluated
                        isUpdated.toggle()
                        
                    } label: {
                        HStack {
                            Text("Evaluated")
                            Image(systemName: "checkmark")
                                .isHidden(!(selectedEvaluatedOrNotFilter == .evaluated) || (selectedEvaluatedOrNotFilter == .all))
                        }
                    }
                    
                    Button {
                        selectedEvaluatedOrNotFilter = selectedEvaluatedOrNotFilter == .notEvaluated ? nil : .notEvaluated
                        isUpdated.toggle()
                        
                    } label: {
                        HStack {
                            Text("Not Evaluated")
                            Image(systemName: "checkmark")
                                .isHidden(!(selectedEvaluatedOrNotFilter == .notEvaluated) || (selectedEvaluatedOrNotFilter == .all))
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 13) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(Color.gray160)
                
                Text("Filters")
                    .foregroundColor(Color.gray160)
            }
            
        }
        .frame(width: 132.toScreenSize(), height: 35.toScreenSize(), alignment: .center)
        .menuStyle(BorderedButtonMenuStyle())
        
    }
    
}


