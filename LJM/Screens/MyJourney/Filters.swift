//
//  Filters.swift
//  LJM
//
//  Created by Marco Tammaro on 01/12/21.
//

import SwiftUI

class FiltersModel: ObservableObject {
    
    /** Stores all the available filters by saving */
    var allFilters: [FiltersModelData]
    
    /** Dictionary where the key is the kind and the value is the types array, used to save the filters applaied by the user.
     
        Example:
            [
                "Main" : ["Core"],
                "Strands" : [],
                "Path"  :  ["Frontend", "Backend"],
                "Sort by" : [],
            ]
     */
    @Published var selectedFilters: Dictionary<String, Array<String>>
    
    struct FiltersModelData {
        var order: Int
        var kind: String
        var types: [String]
    }
    
    init(){
        // initializing allFilters
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
                             types: ["Date", "Name"])
        
        ]
        
        // initializing selectedFilters
        self.selectedFilters = [:]
        for data in self.allFilters {
            self.selectedFilters[data.kind] = []
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

struct Filters: View {
    
    private let model = FiltersModel()
    var onFiltersChange: (Dictionary<String, Array<String>>) -> ()
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            
            ForEach(model.sortedKinds, id: \.self) { kind in
                
                VStack(alignment: .leading){
                    Text(kind).foregroundColor(.gray)
                    Divider()
                    ForEach(model.getTypesByKind(kind: kind), id: \.self) { filter in
                        
                        FiltersRow(text: filter, onTap: {
                            model.selectedFilters[kind]?.append(filter)
                            self.onFiltersChange(model.selectedFilters)
                        })
                        
                    }
                }
            }
        }
    }
}

struct FiltersRow: View {
    
    var text: String
    var onTap : () -> ()
    @State var selected: Bool = false
    
    var body: some View {
        HStack{
            Text(text)
            Spacer()
            if self.selected {
                Image(systemName: "checkmark")
            }
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
        .onTapGesture {
            self.onTap()
            self.selected.toggle()
        }
       
    }
 }

struct Filters_Previews: PreviewProvider {
    static var previews: some View {
        Filters(onFiltersChange: {_ in})
    }
}
