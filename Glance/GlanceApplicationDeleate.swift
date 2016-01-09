//
//  AppDelegate.swift
//  Glance
//
//  Created by Joseph Daniels on 6/7/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import Cocoa
import GlanceKit
import OAuthSwift
import ReactiveCocoa

var _sharedInstance: GlanceApplicationDelegate? = nil

@NSApplicationMain
class GlanceApplicationDelegate : GlanceKitApplicationDelegate, NSApplicationDelegate {

    var storyboard:NSStoryboard
    var wc:NSWindowController?
        var sc:NSWindowController?
    var windowManager:GlanceWindowManager


    static func sharedInstance() -> GlanceApplicationDelegate{
    	return  _sharedInstance!
    }
    override init(){
        windowManager = GlanceWindowManager()
        storyboard = NSStoryboard(name: "Main", bundle: nil)
        super.init()
        _sharedInstance = self
    }

    override func start(){
        super.start();
        wc = GlanceWindowController(windowNibName: "")
        sc = ControlCenterWindowController()
        windowManager.start()
//        GlanceServices.sharedInstance().setNeedsUpdate()
//        var w = wc!.window
        wc?.showWindow(wc?.window)
        sc?.showWindow(sc?.window)
    }

//    func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
//        if (url.host == "oauth-callback") {
//            if (url.path!.hasPrefix("/twitter")){
//                OAuth1Swift.handleOpenURL(url)
//            }
//            if ( url.path!.hasPrefix("/github" )){
//                OAuth2Swift.handleOpenURL(url)
//            }`
//        }
//        return true
//    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        start()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    internal func applicationHandleOpenURL(url: NSURL) {
        if (url.host == "oauth.callback") {
            if (url.path!.hasPrefix("/twitter") ||
                    url.path!.hasPrefix("/flickr") ||
                    url.path!.hasPrefix("/fitbit") ||
                    url.path!.hasPrefix("/withings") ||
                    url.path!.hasPrefix("/linkedin") ||
                    url.path!.hasPrefix("/bitbucket") ||
                    url.path!.hasPrefix("/smugmug") ||
                    url.path!.hasPrefix("/intuit") ||
                    url.path!.hasPrefix("/zaim") ||
                    url.path!.hasPrefix("/tumblr")) {
                OAuth1Swift.handleOpenURL(url)
            }
            if ( url.path!.hasPrefix("/github" ) ||
                    url.path!.hasPrefix("/instagram" ) ||
                    url.path!.hasPrefix("/foursquare") ||
                    url.path!.hasPrefix("/dropbox") ||
                    url.path!.hasPrefix("/dribbble") ||
                    url.path!.hasPrefix("/salesforce") ||
                    url.path!.hasPrefix("/google") ||
                    url.path!.hasPrefix("/linkedin2") ||
                    url.path!.hasPrefix("/slack")) {
                OAuth2Swift.handleOpenURL(url)
            }
        } else {
            // Google provider is the only one wuth your.bundle.id url schema.
            OAuth2Swift.handleOpenURL(url)
        }
    }

}

