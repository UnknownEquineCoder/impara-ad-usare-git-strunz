//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Text("0 0 0 0 0")
            }
            
            Text("- 01/01/20")
            
            Button(action: {
                // DELETE FUNC
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(Color.customBlack)
            }
        }.background(Color.customDarkGrey)
    }
}

struct HistoryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryProgressView()
    }
}
