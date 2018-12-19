//
//  BorderDescriptor.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/19/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

struct BorderDescriptor {
    var color: CGColor? = nil
    var width: CGFloat = 0.0
    
    static var none : BorderDescriptor {
        return BorderDescriptor()
    }
    
    static var hairline : BorderDescriptor {
        var border = BorderDescriptor()
        border.color = UIColor.black.cgColor
        border.width = .hairline
        return border
    }
}
