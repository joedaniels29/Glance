//
// Created by Joseph Daniels on 12/19/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import Cocoa
import ReactiveCocoa
import Cartography

class StoryListViewController:NSViewController, NSTableViewDataSource, NSTableViewDelegate{

    var tableView:NSTableView!
    var tweets: MutableProperty<[TTweet]> = MutableProperty([])
    override func loadView() {
        self.view = NSView()
        tableView = NSTableView()
        tableView.setDelegate( self)
        tableView.setDataSource(self)
        self.view.addSubview(tableView)
        constrain(tableView) {
            view in view.size == view.superview!.size; view.center == view.superview!.center
        }
    }
    override func viewDidAppear() {
        print(self.view.frame)
    }

    @available(OSX 10.10, *) override func viewDidLoad() {
        super.viewDidLoad()
        


        Twitter.instance.authorizationStatus => { [unowned self] in
            switch($0){
            case .Authorized(_):
                   self.tweets <~ TwitterRouter.StatusesHomeTimeline.tweets().ignoreNil()
            default:
            	()
            }
        }
        tweets => { [unowned self] _ in self.tableView.reloadData()}

        tableView.registerNib(NSNib(nibNamed:"TwitterCell", bundle:nil), forIdentifier: "story")
        tableView.addTableColumn(NSTableColumn(identifier: "story"))
    }

    func numberOfRowsInTableView(_ tableView: NSTableView!) -> Int {
        print(tweets.value.count)
        return tweets.value.count
    }

    func tableView( tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        var cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! TTweetMiniView

//        cellView.username.stringValue = tweets.value[row].user!["name"] as! String
        cellView.tweet.stringValue = tweets.value[row].text!

        return cellView
    }

//    func makeViewForDataType(object:AnyObject) -> AnyObject?{
//        return

//    }
    


}
