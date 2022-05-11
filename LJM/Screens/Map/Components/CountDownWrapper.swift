//
//  CountDown.swift
//  LJM
//
//  Created by Laura Benetti on 30/11/20.
//

import Foundation
import SwiftUI
import Combine

struct CountDownWrapper: View {
    @State var value: Int = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isShowing: Bool = true
    
    var body: some View {
        Text("\(value)")
            .opacity(isShowing ? 1 : 0)
            .onReceive(timer) { _ in
                if (value > 0) {
                    value -= 1
                } else {
                    isShowing = false
                }
            }
    }
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDownWrapper()
    }
}
