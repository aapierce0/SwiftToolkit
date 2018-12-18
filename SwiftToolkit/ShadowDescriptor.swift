//
//  ShadowDescriptor.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public struct ShadowDescriptor {
    public var radius: CGFloat = 0.0
    public var offset: CGSize = .zero
    public var opactiy: Float = 0.0
    public var color: CGColor? = nil
    public var path: CGPath? = nil
    
    /// Convenience property for converting CGColor to UIColor
    public var uiColor: UIColor? {
        get { return color.map(UIColor.init(cgColor:)) }
        set { color = newValue?.cgColor }
    }
}

public extension ShadowDescriptor {
    static let none = ShadowDescriptor()
    
    static let dropSubtle: ShadowDescriptor = {
        var shadow = ShadowDescriptor()
        shadow.radius = 1.0
        shadow.offset = CGSize(width: 0.0, height: .hairline)
        shadow.uiColor = .black
        shadow.opactiy = 0.2
        return shadow
    }()
    
    static let documentDropShadow: ShadowDescriptor = {
        var shadow = ShadowDescriptor.dropSubtle
        shadow.opactiy = 0.4
        return shadow
    }()
    
}
