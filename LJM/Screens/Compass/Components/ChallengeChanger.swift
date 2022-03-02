//
//  ChallengeChanger.swift
//  LJM
//
//  Created by Laura Benetti on 28/02/22.
//

import Foundation
import SwiftUI

struct ChallengeChanger: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Button(action: {
                            print("do something")
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
            Button(action: {
                            print("do something")
                        }) {
                            Text("NC1")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }.disabled(true)
            Button(action: {
                            print("do something")
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
    }
}

struct ChallengeChanger_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeChanger()
    }
}
}
