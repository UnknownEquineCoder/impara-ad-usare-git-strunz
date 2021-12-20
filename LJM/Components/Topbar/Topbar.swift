//
//  Topbar.swift
//  LJM
//
//  Created by Tony Tresgots on 20/12/2021.
//

import SwiftUI

struct Topbar: View {
    var title: String
    var filters: Dictionary<String, Array<String>>
    var fromCompass: Bool?
    
    @Binding var scrollTarget: Bool
    @Binding var toggleFilters: Bool
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        // scroll view index to 1
                        scrollTarget.toggle()
                        toggleFilters = true
                        
                    } label: {
                        HStack {
                            Text("Filters \(getNumberOfFilters(filters: filters).count == nil || getNumberOfFilters(filters: filters).count == 0 ? "" : "(\(getNumberOfFilters(filters: filters).count != 1 ? ("\(getNumberOfFilters(filters: filters).count)") : "\(getNumberOfFilters(filters: filters).first ?? "")"))")")
                            
                            Image(systemName: "chevron.up")
                                .font(.system(size: 10))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)
                    .isHidden(fromCompass ?? false, remove: fromCompass ?? false)
                }
            }
            .padding(.vertical, 20)
            .background(Color.darkThemeBackgroundColor)
            .padding(.horizontal, -20)
            .ignoresSafeArea()
            
            Spacer()
        }
        .ignoresSafeArea()
    }

    func getNumberOfFilters(filters: Dictionary<String, Array<String>>) -> [String] {
        
        let values = filters.map {$0.value}
        var arrayValues = [String]()
        
        for value in values {
            arrayValues.append(contentsOf: value)
        }
                
        return arrayValues
    }
}

