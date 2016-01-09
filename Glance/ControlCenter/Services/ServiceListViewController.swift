//
//  ServiceListViewController.swift
//  Glance
//
//  Created by Joseph Daniels on 10/8/15.
//  Copyright © 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
class ServiceCell:NSTableCellView{

    @IBOutlet weak var image: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
}


class ServiceListViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource{
    let services = ServiceController.instance.services
    var selectedService: MutableProperty<Service?> = MutableProperty(nil)

    @IBOutlet weak var outlineView: NSOutlineView!
    func outlineView(outlineView: NSOutlineView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
        guard let item = item else {
            return services.count
        }
        
        return 1
    }

    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return services[index] as! AnyObject
    }

    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        guard let cell =  outlineView.makeViewWithIdentifier("ServiceCell", owner: nil) as? ServiceCell, item = item as? Service.Type else{ return nil}
        cell.nameLabel.stringValue = item.service.name
		return cell
    }

    func outlineView(outlineView: NSOutlineView, heightOfRowByItem item: AnyObject) -> CGFloat{
        return 45
    }

    func outlineView( outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn!, byItem item: AnyObject!) -> AnyObject! {
        guard let item = item as? Service else {
            return nil
        }
        return item.name
    }
    func outlineViewSelectionDidChange(notification: NSNotification) {
        var sel =  self.outlineView.selectedRow
        switch sel {
        case 0..<services.count:
            self.selectedService.value = services[self.outlineView.selectedRow].service
            
            
        default:
            print("error")
        }
    }
}