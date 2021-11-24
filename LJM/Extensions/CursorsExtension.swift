//
//  CursorsExtension.swift
//  LJM
//
//  Created by Laura Benetti on 24/11/21.
//

import Foundation
import SwiftUI

extension View {
    public func cursor(_ cursor: NSCursor) -> some View {
        self.onHover { inside in
            if inside {
                cursor.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}
