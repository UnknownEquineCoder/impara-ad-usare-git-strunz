//
//  SearchBarSideBar.swift
//  LJM
//
//  Created by Tony Tresgots on 02/12/2020.
//

import SwiftUI

struct SearchBarSideBar: View {
    @Binding var showSearchBarSideBar: Bool
    
    var body: some View {
        
        if !showSearchBarSideBar {
            VStack(alignment: .trailing) {
                Text("5 results")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.customBlack)
                    .padding(.trailing, 40)
                    .padding(.top, 20)
                
                Divider().background(Color.customDarkGrey).padding(.trailing, 10).padding(.leading, 10)
                
                ScrollView(showsIndicators: true) {
                    LazyVStack {
                        SearchBarSideBarCell()
                        Divider().background(Color.customDarkGrey).padding(.trailing, 10).padding(.leading, 10)
                        SearchBarSideBarCell()
                        Divider().background(Color.customDarkGrey).padding(.trailing, 10).padding(.leading, 10)
                        SearchBarSideBarCell()
                        Divider().background(Color.customDarkGrey).padding(.trailing, 10).padding(.leading, 10)
                        SearchBarSideBarCell()
                    }.padding(10)
                }
                
            }.frame(width: 280, height: 1000, alignment: .top)
            .background(Color.white).border(Color.customDarkGrey)
            .offset(x: -5)
            
        }
    }
}

struct SearchBarSideBarCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Business")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(Color.customCyan)
            Text("Learn how to publish an app on the App Store")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.customDarkGrey)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
    }
}

struct SearchBarSideBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarSideBar(showSearchBarSideBar: .constant(true))
    }
}
