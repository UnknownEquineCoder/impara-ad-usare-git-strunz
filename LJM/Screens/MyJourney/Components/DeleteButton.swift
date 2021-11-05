//
//  DeleteButton.swift
//  LJM
//
//  Created by Laura Benetti on 04/11/21.
//

import Foundation
import SwiftUI

struct DeleteButton: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete this Learning Objective?"),
                message: Text("You can't undo this action"),
                primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {

    static var previews: some View {
        DeleteButton()
    }
}
