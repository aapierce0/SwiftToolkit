//
//  ViewLayerDescriptor.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/19/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import Foundation

public struct ViewLayerDescriptor : Equatable {
    public var cornerRadius : CGFloat = 0
    public var masksToBounds : Bool = false
    public var shadow : ShadowDescriptor = .none
    public var border : BorderDescriptor = .none
    
    init() {}
    
    init(describing layer : CALayer) {
        cornerRadius = layer.cornerRadius
        masksToBounds = layer.masksToBounds
        shadow = layer.shadow
        border = layer.border
    }
}
