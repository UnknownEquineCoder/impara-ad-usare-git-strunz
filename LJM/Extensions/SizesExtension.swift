//
//  SizesExtension.swift
//  LJM
//
//  Created by Laura Benetti on 02/12/20.
//

import Foundation

public extension Double {
    func toFontSize() -> Self {
        return self * 0.82
    }
    
    func toScreenSize() -> Self {
        return self * 0.872
    }
}

public extension CGFloat {
    func toFontSize() -> Self {
        return self * 0.82
    }
    
    func toScreenSize() -> Self {
        return self * 0.872
    }
}

public extension Int {
    func toFontSize() -> CGFloat {
        return CGFloat(self) * 0.82
    }
    
    func toScreenSize() -> CGFloat {
        return CGFloat(self) * 0.872
    }
}
