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
    
    /** Struct to store all the filters properties*/
    private struct FiltersModelData {
        /** The kind of filter that rapresent the group in whitch the types belongs to*/
        var kind: String
        /** Stores true if this filter kind should be selectable only once*/
        var isSingleSelection: Bool
        /** Stores all the available filters for the corresponding kind */
        var types: [String]
    }
    
    init(viewType: FiltersView){
        self.viewType = viewType
        
        switch viewType {
        case .journey:
            self.allFilters = [
            
                FiltersModelData(kind: "Main",
                                 isSingleSelection: true,
                                 types: ["Core", "Elective"]),
                FiltersModelData(kind: "Strands",
                                 isSingleSelection: false,
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(kind: "Path",
                                 isSingleSelection: true,
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"]),
                FiltersModelData(kind: "Sort by",
                                 isSingleSelection: true,
                                 types: ["Date", "Name"])
            ]
        
        case .map:
            self.allFilters = [
            
                FiltersModelData(kind: "Main",
                                 isSingleSelection: true,
                                 types: ["Core", "Elective"]),
                FiltersModelData(kind: "Status",
                                 isSingleSelection: true,
                                 types: ["Evaluated", "Not Evaluated"]),
                FiltersModelData(kind: "Strands",
                                 isSingleSelection: false,
                                 types: ["App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(kind: "Path",
                                 isSingleSelection: false,
                                 types: ["UI/UX", "Frontend", "Backend", "Game Design", "Game Development",
                                         "Business/Entrepreneuship", "Project/Product Manager"]),
                FiltersModelData(kind: "Sort by",
                                 isSingleSelection: true,
                                 types: ["Date", "Name"])
            ]
            
        }
       
    }
    
    /** Return the FilterModelData.kinds sorted by FilterModelData.order */
    var kinds: [String] {
        return allFilters.map{ $0.kind }
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
