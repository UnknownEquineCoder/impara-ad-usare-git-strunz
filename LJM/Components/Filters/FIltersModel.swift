//
//  FIltersModel.swift
//  LJM
//
//  Created by Marco Tammaro on 03/12/21.
//

import Foundation

class FiltersModel: ObservableObject {
    
    /** Stores all the available filters by saving */
    private var allFilters: [FiltersModelData]
    /** Filters are both available for journey and map view, this will change the behavior gor both*/
    private var viewType: FiltersView
    
    private struct FiltersModelData {
        /** Index of the order in the filers view */
        var order: Int
        /** The kind of filter that rapresent the group in whitch the types belongs to*/
        var kind: String
        /** Stores all the available filters for the corresponding kind */
        var types: [String]
        /** Stores true if this filter kind should be selectable only once*/
        var isSingleSelection: Bool
    }
    
    init(viewType: FiltersView){
        self.viewType = viewType
        
        switch viewType {
        case .journey:
            self.allFilters = [
            
                FiltersModelData(order: 0,
                                 kind: "Main",
                                 types: ["Core", "Elective"],
                                 isSingleSelection: true),
                FiltersModelData(order: 1,
                                 kind: "Strands",
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills",               "Technical"],
                                 isSingleSelection: false),
                FiltersModelData(order: 2,
                                 kind: "Path",
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"],
                                 isSingleSelection: true),
                FiltersModelData(order: 3,
                                 kind: "Sort by",
                                 types: ["Date", "Name"],
                                 isSingleSelection: true)
            ]
        
        case .map:
            self.allFilters = [
            
                FiltersModelData(order: 0,
                                 kind: "Main",
                                 types: ["Core", "Elective", "Evaluated", "Not Evaluated"],
                                 isSingleSelection: true),
                FiltersModelData(order: 1,
                                 kind: "Strands",
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"],
                                 isSingleSelection: false),
                FiltersModelData(order: 2,
                                 kind: "Path",
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"],
                                 isSingleSelection: false),
                FiltersModelData(order: 3,
                                 kind: "Sort by",
                                 types: ["Date", "Name"],
                                 isSingleSelection: true)
            ]
            
        }
       
    }
    
    /** Return the FilterModelData.kinds sorted by FilterModelData.order */
    var sortedKinds: [String] {
        var allFiltersKind: [String] = []
        for data in allFilters.sorted(by: { l, r in
            return l.order < r.order
        }) {
            allFiltersKind.append(data.kind)
        }
        return allFiltersKind
    }
    
    /** Return the FilterModelData.types of the correponding kind */
    func getTypesByKind(kind: String) -> [String] {
        return self.allFilters.first { data in
            data.kind == kind
        }?.types ?? []
    }
    
    /** Return if the correponding kind is a single selection*/
    func isSingleSelection(kind: String) -> Bool {
        return self.allFilters.first { data in
            data.kind == kind
        }?.isSingleSelection ?? false
    }
}
