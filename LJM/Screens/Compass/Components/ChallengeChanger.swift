//
//  ChallengeChanger.swift
//  LJM
//
//  Created by Laura Benetti on 28/02/22.
//

import Foundation
import SwiftUI

struct ChallengeChanger: View {
    @Binding var selectedIndex : Int
    let challenges : [Challenge]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Button(action: {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .disabled(selectedIndex == 0)
            Button(action: {
                if challenges.count > 0 {
                    selectedIndex = challenges.count - 1
                } else {
                    selectedIndex = 0
                }
            }) {
                Text("\(challenges[selectedIndex].ID)")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .disabled(true)
            Button(action: {
                if selectedIndex < challenges.count - 1 {
                    selectedIndex += 1
                }
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .disabled(selectedIndex == challenges.count - 1)
        }
    }
}
    struct ChallengeChanger_Previews: PreviewProvider {
        static var previews: some View {
            ChallengeChanger(selectedIndex: .constant(0), challenges: [])
        }
    }
