//
//  HistoryProgressView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/01/2021.
//

import SwiftUI

struct HistoryProgressView: View {
    var maximumRating = 5
    var rating = 3
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 3) {
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    Image(systemName: "circle.fill")
                }
            }
            
            Text("- 01/01/20")
            
            Button(action: {
                // DELETE FUNC
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(Color.customBlack)
            }.buttonStyle(PlainButtonStyle())
        }.frame(height: 30, alignment: .center)
        .padding(.leading, 10).padding(.trailing, 10)
        .background(Color.customDarkGrey)
        .cornerRadius(30 / 2)
    }
}

struct HistoryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryProgressView()
    }
}
