//
//  BorderDescriptor.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/19/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public struct BorderDescriptor : Equatable {
    public var color: CGColor? = nil
    public var width: CGFloat = 0.0
    
    public static var none : BorderDescriptor {
        return BorderDescriptor()
    }
    
    public static var hairline : BorderDescriptor {
        var border = BorderDescriptor()
        border.color = UIColor.black.cgColor
        border.width = .hairline
        return border
    }
}
