//
//  RatingView.swift
//  LJM
//
//  Created by Tony Tresgots on 28/11/2020.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    var maximumRating = 5
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<maximumRating + 1) { number in
                    Button {
                        self.rating = number
                    } label: {
                        Circle()
                            .strokeBorder(Color.customCyan, lineWidth: 2)
                            .background(Circle().foregroundColor(number > rating ? Color.customGrey : Color.customCyan))
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding(.trailing, 50)
            
            Image(systemName: "arrowtriangle.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(Color.customCyan)
                .padding(.trailing, 50)
            
            // TODO: change to  draw triangle instead of image
        }.padding(.top, 20)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
        
    }
}
