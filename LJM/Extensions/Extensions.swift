import SwiftUI
import AppKit

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

extension Array where Element: Equatable {

 // Remove first collection element that is equal to the given `object`:
 mutating func remove(object: Element) {
     guard let index = firstIndex(of: object) else {return}
     remove(at: index)
 }
}

// Screen sizes
extension NSScreen {
    static let screenWidth = NSScreen.main?.frame.width
    static let screenHeight = NSScreen.main?.frame.height
    static let screenSize = NSScreen.main?.frame.size
}

extension Bool: Comparable {
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        
        if lhs == rhs { return false }
        
        switch(lhs, rhs) {
        case (false, _):
            return true
        case (true, _):
            return false
        }
    }
}
