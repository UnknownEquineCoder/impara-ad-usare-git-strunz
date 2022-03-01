//
//  ChallengeChanger.swift
//  LJM
//
//  Created by Laura Benetti on 28/02/22.
//

import Foundation
import SwiftUI

struct ChallengeChanger: View {

    var body: some View {
        HStack{
            Button(action: {
                            print("do something")
                        }) {
                            Image(systemName: "chevron.backward")
                            .foregroundColor(Color.white)
                        }
            Button(action: {
                            print("do something")
                        }) {
                            Text("NC1")
                           .foregroundColor(Color.white)
                        }
            Button(action: {
                            print("do something")
                        }) {
                            Image(systemName: "chevron.right")
                            .foregroundColor(Color.white)
                        }
    }
}

struct ChallengeChanger_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeChanger()
    }
}
}
