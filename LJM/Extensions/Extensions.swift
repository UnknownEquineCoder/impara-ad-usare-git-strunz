import SwiftUI
import AppKit
import Introspect

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

// Remove List background color bugged
extension List {
  /// List on macOS uses an opaque background with no option for
  /// removing/changing it. listRowBackground() doesn't work either.
  /// This workaround works because List is backed by NSTableView.
  func removeBackground() -> some View {
    return introspectTableView { tableView in
      tableView.backgroundColor = .clear
      tableView.enclosingScrollView!.drawsBackground = false
    }
  }
}
