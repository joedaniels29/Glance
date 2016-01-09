//
//  GlanceFullViewController.swift
//  Glance
//
//  Created by Joseph Daniels on 7/18/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import Cartography



public class GlanceFullViewController: NSViewController {

    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.preferredContentSize = NSSize(width: 300, height: 300)
    }

    override public func loadView() {
        self.view = GlanceFullView()
        let s = NSScreen.mainScreen()!.frame
        self.view.setFrameSize(CGSize(width: s.size.width, height: s.height))
        self.view.setFrameOrigin(NSPoint(x: 0, y: 0))

    }

    override public func viewDidLoad() {
//        addGlance(NSStoryboard(name: "Main", bundle: nil).instantiateControllerWithIdentifier("s") as! GlanceViewController)
        
        addGlance(NSStoryboard(name: "Main", bundle: nil).instantiateControllerWithIdentifier("timeline") as! GlanceViewController)
    }

    func addGlance(glance: GlanceViewController) {
        addGlanceContainer(self.defaultContainer().init(glance:glance)!)
    }
    func defaultContainer() -> GlanceContainerViewController.Type{
        return GlanceContainerViewController.self
    }

    func addGlanceContainer(container: GlanceContainerViewController) {
        self.addChildViewController(container)
        self.view.addSubview(container.view, positioned: .Above, relativeTo: nil)

        container.view.setFrameOrigin(CGPoint(x: 0, y: 10))
        container.view.setFrameSize(NSSize(width: 700, height: 700))

    }
}