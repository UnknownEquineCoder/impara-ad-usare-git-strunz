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
