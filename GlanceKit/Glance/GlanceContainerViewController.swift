//
// Created by Joseph Daniels on 8/31/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import Runes
import ReactiveCocoa
import Cartography
class GlanceContainerViewController:NSViewController {
    var glance:MutableProperty<GlanceViewController>
    var disposables: [Disposable] = []


    required init?(glance:GlanceViewController = GlanceViewController(nibName: nil, bundle:nil)!){
        self.glance = MutableProperty(glance)
        super.init(nibName:nil, bundle:nil)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        disposables.map{ $0.dispose() }
    }
    override func loadView(){
        self.view = GlanceContainerView()
    }
    override func viewDidLoad(){

        disposables.append(glance.producer.map{ Optional($0) }.combinePrevious(nil).startOn(UIScheduler()).startWithNext{[weak self] (previous, next) in
            if let previous = previous where previous.viewLoaded {
                previous.view.removeFromSuperview()
            }
            if let me = self where me.viewLoaded{
                me.view.addSubview <^> next?.view
                if let n = next?.view{
                    constrain(n) {
                        view in view.size == view.superview!.size; view.center == view.superview!.center
                    }
                }
            }
            
        })
    }
    func configure(){
        disposables.append(glance.producer.map{ Optional($0) }.combinePrevious(nil).startWithNext{[weak self] (previous, next) in
            previous?.removeFromParentViewController()
            if let me = self {
                me.addChildViewController <^> next
            }
        })
    }

}
