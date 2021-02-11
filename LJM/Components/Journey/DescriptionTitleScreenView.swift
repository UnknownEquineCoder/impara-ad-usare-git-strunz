//
//  DescriptionTitleScreenView.swift
//  LJM
//
//  Created by Tony Tresgots on 10/02/2021.
//

import SwiftUI

struct DescriptionTitleScreenView: View {
    
    var desc : String
    
    var body: some View {
        Text(desc)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(Color.customDarkGrey)
            .padding(.top, 20)
            .padding(.trailing, 90)
        
        Rectangle().frame(height: 1).foregroundColor(Color.customDarkGrey)
    }
}

struct DescriptionTitleScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTitleScreenView(desc: "DESC")
    }
}
