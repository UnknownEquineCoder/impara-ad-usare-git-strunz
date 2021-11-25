//
//  ContextMenuTest.swift
//  LJM
//
//  Created by Laura Benetti on 25/10/21.
//

import Foundation
import SwiftUI

struct AddLOButton: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {

        Button {
        } label: {
            Text("Add a Learning Objective")
                .foregroundColor(.white)
        }.buttonStyle(BorderedButtonStyle())
}
}


struct AddLOButton_Previews: PreviewProvider {

    static var previews: some View {
        AddLOButton()
    }
}




