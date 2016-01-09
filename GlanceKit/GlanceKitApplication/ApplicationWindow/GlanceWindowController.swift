//
//  ExampleWindowController.swift
//  Glance
//
//  Created by Joseph Daniels on 6/20/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics


import Cocoa
import ReactiveCocoa


public class GlanceWindowController: NSWindowController {
    override public func loadWindow() {
        self.window = GlanceFullWindow(contentRect: NSScreen.mainScreen()!.frame, styleMask: 0, backing: .Buffered, `defer`: false, screen: NSScreen.mainScreen())
        self.window?.contentViewController =  GlanceFullViewController(nibName: nil, bundle: nil)!
    }
    override public func windowDidLoad() {
		if let w = self.window as? GlanceFullWindow {
            w.configureGlanceSpecificProperties()
            self.showWindow(self)
        }else {
            print("window no load", terminator: "")
        }

    }
    
   
}
