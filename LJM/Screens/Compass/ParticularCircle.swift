//
//  ParticularCircle.swift
//  LJM
//
//  Created by Laura Benetti on 25/02/21.
//

import Foundation
import SwiftUI

struct CircleAroundAPoint: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addEllipse(in:
                                CGRect(x: rect.midX,
                                       y: rect.midY,
                                       width: rect.width/2,
                                       height: rect.height/2)
            )
        }
    }
    
    func path(around point: CGPoint, with size: CGSize) -> Path {
        Path { path in
            path.addEllipse(in:
                                CGRect(
                                    x: point.x - size.width/2,
                                    y: point.y - size.height/2,
                                    width: size.width,
                                    height: size.height)
            )
        }
    }
}
