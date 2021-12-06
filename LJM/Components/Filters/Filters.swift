//
//  Filters.swift
//  LJM
//
//  Created by Marco Tammaro on 01/12/21.
//

import SwiftUI

enum FiltersView {
    case journey, map
}

struct Filters: View {
    
    /** Reference to filters model that stores the data */
    private let model: FiltersModel
    var viewType: FiltersView
    /** Return the filters selected by the user
        Return example:
            [
                "Main" : ["Core"],
                "Strands" : [],
                "Path"  :  ["Frontend", "Backend"],
                "Sort by" : [],
            ]
     
     */
    var onFiltersChange: (Dictionary<String, Array<String>>) -> ()
    /** Dictionary where the key is the kind and the value is the types array, used to save the filters applaied by the user.
     
        Example:
            [
                "Main" : ["Core"],
                "Strands" : [],
                "Path"  :  ["Frontend", "Backend"],
                "Sort by" : [],
            ]
     */
    @State private var selectedFilters: Dictionary<String, Array<String>> = [: ]
    
    init(viewType: FiltersView, onFiltersChange: @escaping (Dictionary<String, Array<String>>) -> ()) {
        self.viewType = viewType
        self.onFiltersChange = onFiltersChange
        self.model = FiltersModel(viewType: viewType)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            
            ForEach(model.sortedKinds, id: \.self) { kind in
                
                VStack(alignment: .leading){
                    Text(kind).foregroundColor(.gray)
                    Divider()
                    ForEach(model.getTypesByKind(kind: kind), id: \.self) { filter in
                        HStack{
                            
                            Text(filter)
                            Spacer()
                            if self.selectedFilters[kind]?.contains(filter) ?? false {
                                Image(systemName: "checkmark")
                            }
                        }
                        .background(Color.customBlack.opacity(0.0001)) // hot fix to have the entire button clickable
                        .padding(.bottom, 5)
                        .padding(.top, 5)
                        .onTapGesture {
                            
                            if self.selectedFilters[kind]?.contains(filter) ?? false {
                                self.selectedFilters[kind]?.remove(object: filter)
                                self.onFiltersChange(self.selectedFilters)
                                return
                            }
                            
                            if model.singleSelectionFilter.contains(kind) {
                                self.selectedFilters[kind]?.removeAll()
                                self.selectedFilters[kind]?.append(filter)
                                self.onFiltersChange(self.selectedFilters)
                                return
                            }
                           
                            self.selectedFilters[kind]?.append(filter)
                            self.onFiltersChange(self.selectedFilters)
                            return
                            
                        }
                    }
                }
            }
        }.onAppear {
            // initializing selectedFilters
            for data in self.model.allFilters {
                self.selectedFilters[data.kind] = []
            }
        }
    }
}


struct Filters_Previews: PreviewProvider {
    static var previews: some View {
        Filters(viewType: .journey, onFiltersChange: {_ in})
    }
}
