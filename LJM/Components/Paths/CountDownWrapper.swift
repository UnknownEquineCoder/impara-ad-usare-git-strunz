//
//  CountDown.swift
//  LJM
//
//  Created by Laura Benetti on 30/11/20.
//

import Foundation
import SwiftUI
import Combine

class Counter: ObservableObject {
    @Published var value: Int = 5 {
        didSet {
            print(value)
        }
    }
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}


struct CountDownWrapper<V: Vanishable>: View {
    @ObservedObject var counter = Counter() {
        didSet {
            if counter.value == 1 {
                print("NULL")
            }
        }
    }
    
    @State var isShowing: Bool = true
    
    var body: some View {
        V(counter: counter)
            .opacity(isShowing ? 1 : 0)
            .onReceive(counter.timer) { _ in
                if (counter.value > 0) {
                    counter.value -= 1
                } else {
                    isShowing = false
                }
            }
    }
}

struct VanishableView: Vanishable {
    @ObservedObject var counter: Counter
    
    var body: some View {
        Text("\(counter.value)")
    }
}

protocol Vanishable: View {
    init(counter: Counter)
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDownWrapper<VanishableView>()
    }
}
