//
//  ProgressBarGraph.swift
//  LJM
//
//  Created by Laura Benetti on 03/03/21.
//

import Foundation
import SwiftUI

struct ProgressBarGraph: View{
    
    @Percentage var progress: Double
    
    var color: Color = .white
    
    var body: some View{
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray155)
                    
                Capsule()
                    .fill(color)
                    .frame(width: geo.size.width * CGFloat(progress) / 100)
                
            }
            .frame(width: geo.size.width)
            .cornerRadius(8)
        }
        
    }
}


struct ProgressBarGraph_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarGraph(progress: 60)
    }
}

@propertyWrapper struct Percentage<T: FloatingPoint> {
    var wrappedValue: T {
        didSet {
            wrappedValue = min(min(100, wrappedValue), max(0, wrappedValue))
        }
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = min(abs(min(100, wrappedValue)), max(0, wrappedValue))
    }
}
