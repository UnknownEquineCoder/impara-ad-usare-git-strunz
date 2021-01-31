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

struct MultiSelectRow<Model: IdentifiableWithDescriptor>: View {
    
    var model: Model
    @Binding var selectedItems: Set<UUID>
    var isSelected: Bool {
        selectedItems.contains(model.id)
    }
    
    var body: some View {
        HStack {
            Text(self.model.descriptor)
//                .font(.title)
//                .fontWeight(.bold)
            Spacer()
            if self.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        }
        .onTapGesture {
            if self.isSelected {
                self.selectedItems.remove(self.model.id)
            } else {
                self.selectedItems.insert(self.model.id)
            }
        }
    }
}
