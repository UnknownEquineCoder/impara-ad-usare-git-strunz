//
//  FilterChoice.swift
//  LJM
//
//  Created by Laura Benetti on 29/01/21.
//

import Foundation
import SwiftUI

struct FilterChoice: IdentifiableWithDescriptor, Hashable{
    var id: UUID = UUID()
    var descriptor: String
    
}

protocol IdentifiableWithDescriptor: Identifiable {
    var id: UUID {get set}
    var descriptor: String {get set}
}

struct SingleSelectRow<Model: IdentifiableWithDescriptor>: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedSort: String?
    
    var model: Model
    @Binding var selectedItems: Set<UUID>
    var isSelected: Bool {
        selectedSort == model.descriptor
    }
    
    var body: some View {
        HStack {
            Text(self.model.descriptor)
            Spacer()
            if self.model.descriptor == self.selectedSort {
                Image(systemName: "checkmark")
                    .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
            }
        }
        .onTapGesture {
            self.selectedSort = self.model.descriptor
        }
    }
}


struct MultiSelectRow<Model: IdentifiableWithDescriptor>: View {
    @Environment(\.colorScheme) var colorScheme
    
    var model: Model
    @Binding var selectedItems: Set<UUID>
    @Binding var selectedStrands : [String]
    var isSelected: Bool {
        selectedItems.contains(model.id) || selectedStrands.contains(model.descriptor)
    }
    
    var body: some View {
        HStack {
            Text(self.model.descriptor)
//                .font(.title)
//                .fontWeight(.bold)
            Spacer()
            if self.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(colorScheme == .dark ? .white : Color(red: 70/255, green: 70/255, blue: 70/255))
            }
        }
        .onTapGesture {
            if self.isSelected {
                self.selectedItems.remove(self.model.id)
                self.selectedStrands.remove(object: self.model.descriptor)
            } else {
                self.selectedItems.insert(self.model.id)
                self.selectedStrands.append(self.model.descriptor)
            }
        }
    }
}
