//
//  customAllert.swift
//  LJM
//
//  Created by denys pashkov on 17/03/22.
//

import SwiftUI

struct customAlert: View {
    var body: some View {
        ZStack{
            
            Color.gray.opacity(0.5).ignoresSafeArea()
            
            VStack(spacing:1){
                HStack{
                    ZStack(alignment:.leading){
                        Color.white
                            
                        
                        Text("Title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.leading, 15)
                        
                    }.frame(height:35)
                }
                
                Divider()
                
                HStack{
                    Image("profile-placeholder").resizable()
                        .frame(width: 100)
                    
                    VStack{
                        Text("LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT ")
                        Text("LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT LONG TEXT ")
                    }
                    
                }
                Spacer()
            }
                .frame(width: 500, height: 250)
                .background(Color.yellow)
                .cornerRadius(5)
                
            
        }
    }
}

struct customAllert_Previews: PreviewProvider {
    static var previews: some View {
        customAlert()
    }
}
