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
            .font(.largeTitle)
        
//            .font(.system(size: 26, weight: .bold))
//            .fontWeight(.semibold)
            .fontWeight(.bold)
            .foregroundColor(Color.customBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
    }
}

struct TitleScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreenView(title: "TITLE")
    }
}
