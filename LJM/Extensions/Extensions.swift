//
//  Extensions.swift
//  LJM
//
//  Created by Tony Tresgots on 26/11/2020.
//

import SwiftUI

// Remove ugly focus ring on textfields borders.

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

extension View {
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
