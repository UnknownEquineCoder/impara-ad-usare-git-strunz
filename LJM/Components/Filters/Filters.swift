//
//  Filters.swift
//  LJM
//
//  Created by Marco Tammaro on 01/12/21.
//

import SwiftUI

enum FiltersView {
    case journey, map, challenge
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
    @Binding private var selectedFilters: Dictionary<String, Array<String>>
    
    init(viewType: FiltersView,challenges: [Challenge], selectedFilters: Binding<Dictionary<String, Array<String>>>, onFiltersChange: @escaping (Dictionary<String, Array<String>>) -> ()) {
        self.viewType = viewType
        self._selectedFilters = selectedFilters
        self.onFiltersChange = onFiltersChange
        self.model = FiltersModel(viewType: viewType, challenges: challengesArrayInIDs(challenges: challenges))
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            
            ForEach(model.kinds, id: \.self) { kind in
                
                VStack(alignment: .leading){
                    
                    // Filter section title
                    Text(kind).foregroundColor(.gray)
//                    Divider()
                    ForEach(model.getTypesByKind(kind: kind), id: \.self) { filter in
                       
                        // Single filter row
                        HStack {
                            Text(filter)
                            Spacer()
                            if self.selectedFilters[kind]?.contains(filter) ?? false {
                                Image(systemName: "checkmark")
                            }
                            
                        }
                        .background(Color.customBlack.opacity(0.0001)) // hot fix to have the entire button clickable
                        .padding([.bottom, .top], 5)
                        .onTapGesture {

                            // Remove if already selected and there are others selected
                            if self.selectedFilters[kind]?.contains(filter) ?? false {
                                if self.selectedFilters[kind]?.count == 1 { return }
                                self.selectedFilters[kind]?.remove(object: filter)
                                self.onFiltersChange(self.selectedFilters)
                                return
                            }
                            
                            // Remove all the previous selected if the tapped filter belongs to
                            // a single selection kind and add the new filter to the selected one
                            if model.isSingleSelection(kind: kind) {
                                self.selectedFilters[kind]?.removeAll()
                                self.selectedFilters[kind]?.append(filter)
                                self.onFiltersChange(self.selectedFilters)
                                return
                            }
                           
                            // Add the new filter to the selected one if the selected filer do
                            // not exist and do not belongs to a single selection kind
                            self.selectedFilters[kind]?.append(filter)
                            self.onFiltersChange(self.selectedFilters)
                            return
                            
                        }
                        if model.getTypesByKind(kind: kind).last! != filter {
                            Divider()
                        }
                        
                    }
                }
            }
        }.onAppear {
            // initializing selectedFilters
            for kind in self.model.kinds {
                self.selectedFilters[kind] = []
            }
        }
    }
}
