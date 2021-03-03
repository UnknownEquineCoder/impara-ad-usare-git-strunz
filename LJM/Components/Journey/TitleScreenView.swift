//
//  TitleScreenView.swift
//  LJM
//
//  Created by Tony Tresgots on 10/02/2021.
//

import SwiftUI

struct TitleScreenView: View {
    var title : String
    
    var body: some View {
        Text(title)
            .font(.system(size: 40, weight: .medium))
            .fontWeight(.medium)
            .foregroundColor(Color.customBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TitleScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreenView(title: "TITLE")
    }
}