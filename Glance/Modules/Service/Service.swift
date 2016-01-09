//
// Created by Joseph Daniels on 9/19/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
import OAuthSwift


protocol ServiceDelegate {
    var handler: (NSURL) -> () { get }
}

protocol Service {
    static var service: Service { get }
    var name: String { get }
    var icon: NSImage { get }
    var storyboard: NSStoryboard { get }

    var baseURL: NSURL { get }

    var settingsContainerViewControllerIdentifier: String { get }
    var settingsContentViewControllerIdentifier: String { get }
//    var delegate: ServiceDelegate { get }
}

extension Service {
    var settingsContainerViewControllerIdentifier: String {
        return "settings"
    }
    var settingsContentViewControllerIdentifier: String {
        return "content"
    }
    var authorize: NSURL {
        return NSURL(string: "oauth-swift://oauth-callback/\(name)")!
    }
    var storyboard: NSStoryboard {
        return NSStoryboard(name: name, bundle: nil)
    }
    func instanciateSettingsViewController() -> NSViewController {
        return self.storyboard.instantiateControllerWithIdentifier(self.settingsContainerViewControllerIdentifier) as! NSViewController
    }
    func instanciateSettingsContentViewController() -> NSViewController {
        return self.storyboard.instantiateControllerWithIdentifier(self.settingsContentViewControllerIdentifier) as! NSViewController
    }


}


//easy setup for services :) !

class BaseService {

}


protocol OAuth: Service {
    //    oauth
    var authorizeUrl: String { get }
    var consumerKey: String { get }
    var consumerSecret: String { get }

    var oauth: OAuthStandard { get }
    var authorizationStatus: MutableProperty<AuthorizationStatus> { get set }

}

extension OAuth {

    var redirectURL: NSURL {
        return NSURL(string: "https://oauth.callback/\(name)")!
    }
}

protocol OAuth1: OAuth {
    var requestTokenUrl: String { get }
    var accessTokenUrl: String { get }
}

extension OAuth1 {
    var oauth: OAuthStandard {
        return oauth1
    }
    var authCallbackSuccess: OAuth1Swift.TokenSuccessHandler {
        return {
            credential, response in

            self.authorizationStatus.value = .Authorized(credential)
        }
    }
    var authCallbackFailure: OAuth1Swift.FailureHandler {
        return {
            failure in
			print(failure)
        }
    }
    var oauth1: OAuth1Swift {
        return OAuth1Swift(
        consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                requestTokenUrl: requestTokenUrl,
                authorizeUrl: authorizeUrl,
                accessTokenUrl: accessTokenUrl
        )
    }
}

protocol OAuth2: OAuth {


    var responseType: String { get }
//for code based authentication
    var accessTokenURL: String? { get }
}

extension OAuth2 {
    var authCallbackSuccess: OAuth2Swift.TokenSuccessHandler  {
        return { credential, response, dict in
            self.authorizationStatus.value = .Authorized(credential)
        }
    }
    var authCallbackFailure: OAuth2Swift.FailureHandler  {
        return { failure in
            print(failure)
        }
    }
    var responseType: String {
        return "token"
    }
    var oauth2: OAuth2Swift {
        return OAuth2Swift(
        consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                authorizeUrl: authorizeUrl,
                responseType: responseType
        )
    }
    var oauth: OAuthStandard {
        return oauth2
    }
}


class OAuthService: BaseService {


}
