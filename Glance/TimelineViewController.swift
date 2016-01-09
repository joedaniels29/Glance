//
// Created by Joseph Daniels on 12/19/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import ReactiveCocoa
import GlanceKit
import Cartography

class TimelineViewController: GlanceViewController {
    var vc:NSViewController!
    @available(OSX 10.10, *) override func viewDidLoad() {
        super.viewDidLoad()
        vc = StoryListViewController(nibName: nil, bundle: nil)!
        self.addChildViewController(vc)

        self.view.addSubview(vc.view)
        constrain(vc.view) {
            view in view.size == view.superview!.size; view.center == view.superview!.center
        }

    }


}
