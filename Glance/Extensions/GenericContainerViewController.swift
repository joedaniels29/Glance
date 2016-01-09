//
// Created by Joseph Daniels on 11/20/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import ReactiveCocoa
import Cartography

class GenericContainerViewController: AppKit.NSViewController {
    var d = CompositeDisposable()
    deinit {
        d.dispose()
    }
    
    let childViewController: MutableProperty<NSViewController?> = MutableProperty(ServicesSplashScreenViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        d += childViewController.producer.combinePrevious(nil).startWithNext{
            [unowned self] (previous, next) in
            if let previous = previous {
                if previous.parentViewController == self {
                    if previous.viewLoaded {
                        previous.view.removeFromSuperview()
                    }
                    previous.removeFromParentViewController()
                }
            }
            if let next = next {
                self.addChildViewController(next)
                self.view.addSubview(next.view)
                constrain(next.view) {view in
                    view.size == view.superview!.size
                    view.center == view.superview!.center
                }
            }
        }
    }
}
