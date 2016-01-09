//
//  ServiceList.swift
//  Glance
//
//  Created by Joseph Daniels on 10/2/15.
//  Copyright © 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
var _twitter: Twitter?;
extension Twitter: OAuth1 {
    var icon: NSImage {
        return NSImage()
    }

    
    static var instance: Twitter {
        switch (_twitter) {
        case .Some(let twitter):
            return twitter
        case .None:
            _twitter = Twitter.init()
            return _twitter!
        }
    }
    
    static var service: Service {
        return self.instance
    }
    var name: String {
        return "Twitter"
    }
    var requestTokenUrl: String {
        return "https://api.twitter.com/oauth/request_token"
    }
    var authorizeUrl: String {
        return "https://api.twitter.com/oauth/authorize"
    }
    var accessTokenUrl: String {
        return "https://api.twitter.com/oauth/access_token"
    }
    var consumerKey: String {
        return "8iF104tUanjjfiwee9pgH5in0"
    }
    var consumerSecret: String {
        return "QCWlVYa3AJNfaqKhjI5iv9sLOMP6mRU2kQOPIZu0Og2cmn32MV"
    }
    
}

var flickr: Flickr?;
extension Flickr: OAuth1 {
    var icon: NSImage {
        return NSImage()
    }
    
    static var instance: Flickr {
        switch (flickr) {
        case .Some(let flickr):
            return flickr
        case .None:
            flickr = Flickr.init()
            return flickr!
        }
    }
    
    static var service: Service {
        return self.instance
    }
    var name: String {
        return "Flickr"
    }
    var requestTokenUrl: String {
        return "https://www.flickr.com/services/oauth/request_token"
    }
    var authorizeUrl: String {
        return "https://www.flickr.com/services/oauth/authorize"
    }
    var accessTokenUrl: String {
        return "https://www.flickr.com/services/oauth/access_token"
    }
    var consumerKey: String {
        return ""
    }
    var consumerSecret: String {
        return ""
    }
    
}

var github: Github?;
extension Github: OAuth2 {
    var icon: NSImage {
        return NSImage()
    }
    
    static var instance: Github {
        switch (github) {
        case .Some(let github):
            return github
        case .None:
            github = Github.init()
            return github!
        }
    }
    static var service: Service {
        return self.instance
    }
    
    var accessTokenURL: String? {
        return nil
    }
    var consumerKey: String {
        return ""
    }
    var consumerSecret: String {
        return ""
    }
    var name: String {
        return "Github"
    }
    
    var authorizeUrl: String {
        return "https://github.com/login/oauth/authorize"
    }
    var accessTokenUrl: String {
        return "https://github.com/login/oauth/access_token"
    }
    var responseType: String {
        return "code"
    }
    
}

var instagram: Instagram?;
extension Instagram: OAuth2 {
    
    var icon: NSImage {
        return NSImage()
    }
    static var service: Service {
        return self.instance
    }
    static var instance: Instagram {
        switch (instagram) {
        case .Some(let instagram):
            return instagram
        case .None:
            instagram = Instagram.init()
            return instagram!
        }
    }
    
    var accessTokenURL: String? {
        return nil
    }
    var consumerKey: String {
        return ""
    }
    var consumerSecret: String {
        return ""
    }
    var name: String {
        return "Instagram"
    }
    
    var authorizeUrl: String {
        return "https://api.instagram.com/oauth/authorize"
    }
    var responseType: String {
        return "token"
    }
}

var tumblr: Tumblr?;
extension Tumblr: OAuth1 {
    var icon: NSImage {
        return NSImage()
    }
    
    static var instance: Tumblr {
        switch (tumblr) {
        case .Some(let tumblr):
            return tumblr
        case .None:
            tumblr = Tumblr.init()
            return tumblr!
        }
    }
    static var service: Service {
        return self.instance
    }
    var name: String {
        return "Tumblr"
    }
    var requestTokenUrl: String {
        return "http://www.tumblr.com/oauth/request_token"
    }
    var authorizeUrl: String {
        return "http://www.tumblr.com/oauth/authorize"
    }
    var accessTokenUrl: String {
        return "http://www.tumblr.com/oauth/access_token"
    }
    var consumerKey: String {
        return ""
    }
    var consumerSecret: String {
        return ""
    }
    
}


//class Foursquare: Service {
//
//
//}
//
//class Fitbit: Service {
//
//
//}
//
//class Withings: Service {
//
//
//}
//
//class Linkedin: Service {
//
//
//}
//
//class Linkedin2: Service {
//
//
//}
//
//class Dropbox: Service {
//
//
//}
//
//class Dribbble: Service {
//
//
//}
//
//class Salesforce: Service {
//
//
//}

//class BitBucket: Service {
//
//
//}
//
//class GoogleDrive: Service {
//
//
//}
//
//class Smugmug: Service {
//
//
//}
//
//class Intuit: Service {
//
//
//}
//
//class Zaim: Service {
//
//
//}


//
//class Slack: Service {
//
//
//}
//
//class Uber: Service {
//
//
//}