//
// Created by Joseph Daniels on 8/6/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import ReactiveCocoa
@IBDesignable public class SolidView: NSView{
    public var userColor:MutableProperty<NSColor?> = MutableProperty(nil)
	
    var color:AnyProperty<NSColor>
    
    override public init(frame frameRect: NSRect) {
        color = AnyProperty(
            initialValue: (userColor.value ?? ThemeEngine.sharedInstance().theme.value.colorPalette.value.backgroundColor.value),
            producer:
            	ThemeEngine.sharedInstance().theme.producer
                    .flatMap(.Latest){$0.colorPalette.producer}
                	.flatMap(.Latest){$0.backgroundColor.producer}
            		.takeUntilReplacement(userColor.producer.ignoreNil())
        )
        super.init(frame:frameRect)
        configure()
    }
    required public init?(coder: NSCoder) {
        color = AnyProperty(
            initialValue: (userColor.value ?? ThemeEngine.sharedInstance().theme.value.colorPalette.value.backgroundColor.value),
            producer:
            ThemeEngine.sharedInstance().theme.producer
                .flatMap(.Latest){$0.colorPalette.producer}
                .flatMap(.Latest){$0.backgroundColor.producer}
                .takeUntilReplacement(userColor.producer.ignoreNil())
        )
        super.init(coder: coder)
        configure()
    }

    func configure(){
        self.wantsLayer = true
        color.producer.startWithNext{[weak self] _ in self?.needsDisplay = true }
    }
    override public var wantsUpdateLayer: Bool { get { return true } }
    public override func updateLayer() {
        layer?.backgroundColor = color.value.CGColor
        layer?.opaque = false
    }
	
    

}
