/**///
//  DarkStylizedView.swift
//  Glance
//
//  Created by Joseph Daniels on 8/3/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit

public class StylizedView : NSVisualEffectView{
    override public init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        configure()
    }
	 required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure(){
        material = .Dark
        blendingMode  = .BehindWindow
        autoresizingMask  = [.ViewWidthSizable, .ViewHeightSizable]
        state = .Active
    }
}
public class DarkStylizedView : StylizedView{
    override func configure(){
        super.configure()
        material = .Dark
    }
}
public class LightStylizedView : StylizedView{
    override func configure(){
        super.configure()
        material = .Light
    }
}