//
//  Topbar.swift
//  LJM
//
//  Created by Tony Tresgots on 20/12/2021.
//

import SwiftUI

struct Topbar: View {
    var title: String
    var filters: [String]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(title)

                Spacer()

                Button {

                } label: {
                    Text("Filters")
                }
                .padding(.trailing, 20)
            }
            .padding(.vertical, 20)
            .background(Color.red)
            .padding(.horizontal, -20)
            .ignoresSafeArea()
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

