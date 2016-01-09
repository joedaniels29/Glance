//
//  ViewController.swift
//  Glance
//
//  Created by Joseph Daniels on 6/7/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Cocoa
import ReactiveCocoa

class BaseGlanceViewController: NSViewController {
    var dateFormatter: NSDateFormatter {
        get{
            let f = NSDateFormatter()
            f.dateFormat = "ss"
            return f
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var textField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        ReactiveCocoa.timer(1.0, onScheduler: QueueScheduler.mainQueueScheduler)
            .map {[weak self] in self?.dateFormatter.stringFromDate($0) ?? ""}
            .startWithNext( { [weak self] in self?.textField.stringValue = $0 })
    }

}

