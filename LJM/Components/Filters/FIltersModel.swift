//
//  FIltersModel.swift
//  LJM
//
//  Created by Marco Tammaro on 03/12/21.
//

import Foundation

class FiltersModel: ObservableObject {
    
    /** Stores all the available filters by saving */
    var allFilters: [FiltersModelData]
    /** Stores the kinds that should be selectable only once*/
    let singleSelectionFilter: Array<String>
    
    /** Filters are both available for journey and map view, this will change the behavior gor both*/
    var viewType: FiltersView
    
    struct FiltersModelData {
        var order: Int
        var kind: String
        var types: [String]
    }
    
    init(viewType: FiltersView){
        self.viewType = viewType
        
        switch viewType {
        case .journey:
            self.allFilters = [
            
                FiltersModelData(order: 0,
                                 kind: "Main",
                                 types: ["Core", "Elective"]),
                FiltersModelData(order: 1,
                                 kind: "Strands",
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(order: 2,
                                 kind: "Path",
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"]),
                FiltersModelData(order: 3,
                                 kind: "Sort by",
                                 types: ["Date", "Name"])]
            
            self.singleSelectionFilter = ["Main", "Path", "Sort by"]
        
        case .map:
            self.allFilters = [
            
                FiltersModelData(order: 0,
                                 kind: "Main",
                                 types: ["Core", "Elective", "Evaluated", "Not Evaluated"]),
                FiltersModelData(order: 1,
                                 kind: "Strands",
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(order: 2,
                                 kind: "Path",
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"]),
                FiltersModelData(order: 3,
                                 kind: "Sort by",
                                 types: ["Date", "Name"])]
            
            
            
            self.singleSelectionFilter = ["Main", "Sort by"]
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
}
