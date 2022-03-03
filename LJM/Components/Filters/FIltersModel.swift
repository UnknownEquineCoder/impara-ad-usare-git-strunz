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
        /** Value that rapresent the default selected filter */
        var initialSelectedFilter: Int
        /** Stores all the available filters for the corresponding kind */
        var types: [String]
    }
    
    init(viewType: FiltersView, challenges : [String]){
        self.viewType = viewType
        var newChallenges : [String] = ["Any"]
        newChallenges.append(contentsOf: challenges)
        switch viewType {
        case .journey:
            self.allFilters = [
            
                FiltersModelData(kind: "Main",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Core", "Elective"]),
                FiltersModelData(kind: "Strand",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(kind: "Path",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Backend", "Business", "Design", "Frontend", "Game Design", "Game Developer","Project Management"]),
                FiltersModelData(kind: "Challenges",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: newChallenges),
                FiltersModelData(kind: "Sort By",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Name", "Date"])
                
            ]
        
        case .map:
            self.allFilters = [
            
                FiltersModelData(kind: "Main",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Core", "Elective"]),
                FiltersModelData(kind: "Status",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Evaluated", "Not Evaluated"]),
                FiltersModelData(kind: "Strand",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(kind: "Path",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Backend", "Business", "Design", "Frontend", "Game Design", "Game Developer","Project Management"]),
                FiltersModelData(kind: "Challenges",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: newChallenges)
            ]
            
        case .challenge:
            self.allFilters = [
            
                FiltersModelData(kind: "Main",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Core", "Elective"]),
                FiltersModelData(kind: "Status",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Evaluated", "Not Evaluated"]),
                FiltersModelData(kind: "Strand",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "App Business and Marketing", "Design", "Process", "Professional Skills", "Technical"]),
                FiltersModelData(kind: "Path",
                                 isSingleSelection: true,
                                 initialSelectedFilter: 0,
                                 types: ["Any", "Backend", "Business", "Design", "Frontend", "Game Design", "Game Developer","Project Management"])
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
    
    /** Return if the correponding kind is a single selection */
    func isSingleSelection(kind: String) -> Bool {
        return self.allFilters.first { data in
            data.kind == kind
        }?.isSingleSelection ?? false
    }
    
    /** Return the default filters */
    func defaultFilters() -> Dictionary<String, Array<String>> {
        var data = Dictionary<String, Array<String>>()
        
        for filter in allFilters{
            data[filter.kind] = [filter.types[filter.initialSelectedFilter]]
        }
        return data
    }
}
