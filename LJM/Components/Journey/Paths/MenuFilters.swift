//
//  MenuFilters.swift
//  LJM
//
//  Created by Laura Benetti on 09/12/20.
//

import Foundation
import SwiftUI


struct MenuFilters: View {
    var stuff = ["one","two","three"]
    @State var index: Int = 1
    var body: some View {
        
       SomeView()
        
    }
    
}


struct SomeView: View {


var body: some View {
    DisclosureGroup("Filters", content: {
        Text("Inside")
    }).frame(width: 240, height: 50)
}
}

public struct MenuPicker<T, V: View>: View {
    
    @Binding var selected: Int
    var array: [T]
    var title: String?
    let mapping: (T) -> V
    
    public init(selected: Binding<Int>, array: [T], title: String? = nil,
                mapping: @escaping (T) -> V) {
        self._selected = selected
        self.array = array
        self.title = title
        self.mapping = mapping
    }
    
    public var body: some View {
        if let existingTitle = title {
            HStack {
                Text(existingTitle)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                menu
            }
        } else {
            menu
        }
    }
    
    var menu: some View {
        Menu(content: {
            ForEach(array.indices, id: \.self) { index in
                Button(action: {
                    selected = index
                }, label: {
                    view(for: index)
                })
            }
        }, label: {
            mapping(array[selected])
        })
    }
    
    @ViewBuilder func view(for index: Int) -> some View {
        if selected == index {
            HStack {
                self.mapping(array[index])
                Spacer(minLength: 0)
                Image(systemName: "checkmark")
            }
        } else {
            self.mapping(array[index])
        }
    }
    
}
    
    
    
    
    
    
    
    struct MenuFilters_Previews: PreviewProvider {
        
        static var previews: some View {
            MenuFilters()
        }
    }




