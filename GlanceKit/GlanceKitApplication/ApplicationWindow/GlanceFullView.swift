//
//  GlanceFullView.swift
//  Glance
//
//  Created by Joseph Daniels on 7/18/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics
import ReactiveCocoa

class GlanceFullView : NSView{
    let backgroundView:AnyProperty<NSView> = {
        return AnyProperty(initialValue: NSView.expandableView(), producer: ThemeEngine.sharedInstance().theme.producer
            .flatMap(.Latest){ $0.defaultWindowBackgroundViewClass.producer }
            .map{ $0.expandableView() }
        )
    }()

    override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(){
        backgroundView.producer.map{ Optional($0) }.combinePrevious(nil).startWithNext{ [weak self] (a:NSView?, b:NSView?) in
    	        a?.removeFromSuperview()
	            if let b = b{
        	        self?.addSubview(b, positioned: .Below, relativeTo: nil)
            	}
            }

    }
    }
