//
//  DropDownMenuSelectPath.swift
//  LJM
//
//  Created by Tony Tresgots on 18/02/2021.
//

import SwiftUI

struct DropDownMenuSelectPath: View {
    var body: some View {
        Menu {
            Button {
                // LOGIC TO  FILTER  ARRAY LOs

            } label: {
                Text("Design")
            }
            Button {
                // LOGIC TO  FILTER  ARRAY LOs

            } label: {
                Text("Business")
            }
        } label: {
            Text("Select your path")
        }.frame(width: 250)
    }
}

struct DropDownMenuSelectPath_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenuSelectPath()
    }
}
