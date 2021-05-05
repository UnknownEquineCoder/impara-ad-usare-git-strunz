import Foundation

public extension BinaryInteger {
    func toFontSize() -> CGFloat {
        return CGFloat(self) * 0.82
    }
    
    func toScreenSize() -> CGFloat {
        return CGFloat(self) * 0.872
    }
}

public extension CGFloat {
    func toFontSize() -> CGFloat {
        return CGFloat(self) * 0.82
    }
    
    func toScreenSize() -> CGFloat {
        return CGFloat(self) * 0.872
    }
}

public extension BinaryInteger {
    
    func toFontSize() -> CGFloat {
        return CGFloat(self) * 0.82
    }
    
    func toScreenSize() -> CGFloat {
        return CGFloat(self) * 0.872
    }
    
}
