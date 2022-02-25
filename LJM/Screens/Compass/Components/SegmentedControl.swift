//
//  SegmentedControl.swift
//  LJM
//
//  Created by Laura Benetti on 22/02/22.
//

import Foundation
import SwiftUI

struct SegmentedControl: View {
    @State private var favoriteColor = 0

    var body: some View {
        VStack {
            Picker("Challenge:", selection: $favoriteColor) {
                Text("MC1").tag(0)
                Text("NC1").tag(1)
//                Text("MC2").tag(2)
//                Text("MC1").tag(3)
//                Text("NC1").tag(4)
//                Text("MC2").tag(5)
//                Text("MC1").tag(6)
//                Text("NC1").tag(7)
            }
            .pickerStyle(.segmented)
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}
