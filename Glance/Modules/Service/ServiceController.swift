//
// Created by Joseph Daniels on 10/2/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation

var _instance = ServiceController()

class ServiceController {
    static var instance: ServiceController {
        return _instance
    }
    public var services:[Service.Type] = [ Twitter.self,
                Flickr.self,
                Github.self,
                Instagram.self,
//                    Foursquare.self,
//                    Fitbit.self,
//                    Withings.self,
//                    Linkedin.self,
//                    Linkedin2.self,
//                    Dropbox.self,
//                    Dribbble.self,
//                    Salesforce.self,
//                    BitBucket.self,
//                    GoogleDrive.self,
//                    Smugmug.self,
//                    Intuit.self,
//                    Zaim.self,
//                    Slack.self,
//                    Uber.self,
                Tumblr.self]
    var settings:[NSViewController.Type] = [ TwitterSettingsViewController.self,
                                             FlickrSettingsViewController.self,
                                             GithubSettingsViewController.self,
                                             InstagramSettingsViewController.self,
                                             TumblrSettingsViewController.self]
    
}
