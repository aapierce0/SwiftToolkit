//
//  CALayer.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public extension CALayer {
    var shadow: ShadowDescriptor {
        get {
            var shadow = ShadowDescriptor()
            shadow.offset = shadowOffset
            shadow.radius = shadowRadius
            shadow.opactiy = shadowOpacity
            shadow.color = shadowColor
            shadow.path = shadowPath
            return shadow
        }
        
        set {
            shadowOffset = newValue.offset
            shadowRadius = newValue.radius
            shadowOpacity = newValue.opactiy
            shadowColor = newValue.color
            shadowPath = newValue.path
        }
    }
}

