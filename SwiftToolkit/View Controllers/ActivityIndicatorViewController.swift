//
//  ActivityIndicatorViewController.swift
//  SwiftToolkit
//
//  Created by Avery Pierce on 12/13/18.
//  Copyright © 2018 Avery Pierce. All rights reserved.
//

import UIKit

public class ActivityIndicatorViewController: UIViewController {
    
    private(set) public weak var activityIndicatorView: UIActivityIndicatorView!
    
    public var isAnimating: Bool = true { didSet { configureIfLoaded() } }
    
    override public func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        loadActivityIndicatorView()
    }
    
    private func loadActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView()
        view.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
        
        activateLayoutConstraintsForActivityIndicatorView()
    }
    
    private func activateLayoutConstraintsForActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configureIfLoaded() {
        if isViewLoaded {
            configure()
        }
    }
    
    private func configure() {
        if isAnimating {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
