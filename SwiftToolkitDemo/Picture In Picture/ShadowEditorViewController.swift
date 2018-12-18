//
//  ShadowEditorViewController.swift
//  SwiftToolkitDemo
//
//  Created by Avery Pierce on 12/18/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit
import SwiftToolkit

extension ShadowEditorViewController : NibBackedViewController {
    static let nibName: String = "ShadowEditorViewController"
    static let nibBundle: Bundle? = .main
}

class ShadowEditorViewController: UIViewController {
    
    enum Notification {
        static let valueDidChange = NSNotification.Name("ShadowEditorViewControllerDidChange")
    }
    
    @IBOutlet weak var verticalOffsetSlider: UISlider!
    @IBOutlet weak var verticalOffsetLabel: UILabel!
    
    @IBOutlet weak var horizontalOffsetSlider: UISlider!
    @IBOutlet weak var horizontalOffsetLabel: UILabel!
    
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var radiusLabel: UILabel!
        
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var opacityLabel: UILabel!
    
    private var _shadowDescriptor : ShadowDescriptor = .none
    var shadowDescriptor : ShadowDescriptor {
        get { return _shadowDescriptor }
        set { setNewShadowDescriptorAndConfigureIfLoaded(newValue) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargetActionBindings()
        configure(with: _shadowDescriptor)
    }
    
    private func addTargetActionBindings() {
        allSliders().forEach(addTargetActionBinding(for:))
    }
    
    private func allSliders() -> [UISlider] {
        return [
            horizontalOffsetSlider,
            verticalOffsetSlider,
            radiusSlider,
            opacitySlider,
        ]
    }
    
    private func addTargetActionBinding(for slider: UISlider) {
        slider.addTarget(self, action: #selector(ShadowEditorViewController.sliderDidUpdate(_:)), for: .valueChanged)
    }
    
    private func setNewShadowDescriptorAndConfigureIfLoaded(_ shadowDescriptor: ShadowDescriptor) {
        _shadowDescriptor = shadowDescriptor
        configureIfLoaded(with: shadowDescriptor)
    }
    
    private func configureIfLoaded(with shadowDescriptor: ShadowDescriptor) {
        if isViewLoaded {
            configure(with: shadowDescriptor)
        }
    }
    
    private func configure(with shadowDescriptor: ShadowDescriptor) {
        configureSliders(with: shadowDescriptor)
        configureLabels(with: shadowDescriptor)
    }
    
    private func currentShadowDescriptor() -> ShadowDescriptor {
        var shadowDescriptor = ShadowDescriptor.none
        shadowDescriptor.offset.width = CGFloat(horizontalOffsetSlider.value)
        shadowDescriptor.offset.height = CGFloat(verticalOffsetSlider.value)
        shadowDescriptor.radius = CGFloat(radiusSlider.value)
        shadowDescriptor.opacity = opacitySlider.value
        return shadowDescriptor
    }
    
    private func configureLabels(with shadowDescriptor: ShadowDescriptor) {
        horizontalOffsetLabel.text = "\(shadowDescriptor.offset.width)"
        verticalOffsetLabel.text = "\(shadowDescriptor.offset.height)"
        radiusLabel.text = "\(shadowDescriptor.radius)"
        opacityLabel.text = "\(shadowDescriptor.opacity)"
    }
    
    private func configureSliders(with shadowDescriptor: ShadowDescriptor) {
        horizontalOffsetSlider.value = Float(shadowDescriptor.offset.width)
        verticalOffsetSlider.value = Float(shadowDescriptor.offset.height)
        radiusSlider.value = Float(shadowDescriptor.radius)
        opacitySlider.value = shadowDescriptor.opacity
    }
    
    @objc private func sliderDidUpdate(_ sender: UISlider) {
        _shadowDescriptor = currentShadowDescriptor()
        configureLabels(with: currentShadowDescriptor())
        postValueDidChangeNotification()
    }
    
    private func postValueDidChangeNotification() {
        NotificationCenter.default.post(name: Notification.valueDidChange, object: self)
    }
}
