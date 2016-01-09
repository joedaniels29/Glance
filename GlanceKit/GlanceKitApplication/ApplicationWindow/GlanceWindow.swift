//
// Created by Joseph Daniels on 7/11/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics


public class GlanceFullWindow:NSWindow, NSWindowDelegate {
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool){
        super.init(contentRect: contentRect, styleMask: aStyle | NSBorderlessWindowMask, backing:bufferingType, `defer`:flag)
        configureGlanceSpecificProperties()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder:coder)
        configureGlanceSpecificProperties()
    }
    public func configureGlanceSpecificProperties(){
        self.backgroundColor = NSColor.clearColor()
        self.opaque = false
        self.styleMask = NSBorderlessWindowMask
//        self.hasTitleBar = false
        self.level = desktopWindowLevel()
        self.hasShadow = false
        self.delegate = self
        self.collectionBehavior = [.Transient, .CanJoinAllSpaces, NSWindowCollectionBehavior.IgnoresCycle]
//    	self.collectionBehavior = NSWindowCollectionBehavior.Transient.union(.CanJoinAllSpaces).union(.IgnoresCycle) S2
    }
    func setSizeToScreen(){
        if let screen =  self.screen{
//            self.setFrame(screen.visibleFrame, display: true)
        }
    }


    func desktopWindowLevel()-> Int{
//        return Int(CGWindowLevelForKey(CGWindowLevelKey.DesktopWindowLevelKey)) S2
        return Int(CGWindowLevelForKey(CGWindowLevelKey.DesktopWindowLevelKey))
    }
}
