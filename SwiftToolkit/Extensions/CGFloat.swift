//
//  CGFloat.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public extension CGFloat {
    static var hairline: CGFloat {
        return 1.0 / UIScreen.main.scale
    }
    
    /// Returns a value between 0.0 and 1.0 as a percentage between `lowerBound` and `upperBound`.
    /// If the value is below `lowerBound`, this function returns 0.0. If the value is above
    /// `upperBound`, this function returns 1.0
    func normalized(lowerBound: CGFloat, upperBound: CGFloat) -> CGFloat {
        let constrainedValue = Swift.max(lowerBound, Swift.min(self, upperBound))
        let zeroBasedValue = constrainedValue - lowerBound
        let normalized = zeroBasedValue / upperBound
        return normalized
    }
}
