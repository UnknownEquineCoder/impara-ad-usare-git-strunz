//
//  CompassMainView.swift
//  LJM
//
//  Created by Laura Benetti on 19/02/21.
//

import SwiftUI

struct CompassView: View, LJMView {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            
            colorScheme == .dark ? Color(red: 30/255, green: 30/255, blue: 30/255) : .white
            
            VStack {
                VStack {
                    HStack {
                        TitleScreenView(title: "Compass")
                            .padding(.top, 114.toScreenSize())
                            
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        DescriptionTitleScreenView(desc: "Compass is your personal progress tracking tool. Here you are able to have a panoramic view of your personal progress.")
                    }
                    DatePickerView().padding(.top, 7.toScreenSize())
                    
                    SliderView()
                    
                    HStack{
                        Spacer()
                        GraphWithOverlay()
                            .frame(width: 395, height: 395)
                            .padding(.all, 45)
                        
                        Spacer(minLength: 214)
                        
                        GraphWithOverlay()
                            .frame(width: 395, height: 395)
                            .padding(.all, 45)
                        
                        Spacer()
                    }
                    LegendView()
                    
                    Spacer()
                }
            }
            .padding(.leading, 70).padding(.trailing, 50)
        }
        
        .frame(minHeight: 1080.toScreenSize())
        
        
    }
    
}



struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}


