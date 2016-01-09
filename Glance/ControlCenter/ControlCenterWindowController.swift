//
// Created by Joseph Daniels on 7/17/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation

import AppKit

class ControlCenterWindowController : RHPreferencesWindowController {
    init(){ServiceController.instance.settings.map{$0.init(nibName:nil, bundle:nil)!}
		var s = GlanceApplicationDelegate.sharedInstance().storyboard
        super.init(viewControllers:[
            s.instantiateControllerWithIdentifier("Glance.ServicesSettingsSplitViewControl")
		])
    }
    override init!(viewControllers controllers: [AnyObject]!, andTitle title: String!) {
        super.init(viewControllers: controllers, andTitle: "Title")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(window: NSWindow?) {
        super.init(window: window)
    }

}
