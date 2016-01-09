//
// Created by Joseph Daniels on 9/30/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import Cocoa
import WebKit
import OAuthSwift
import Cartography
import Runes
import GlanceKit
import ReactiveCocoa

enum AuthorizationWorkflowStep {
    case Authorization
    case Splash
    case Success
}

class UnathorizedAccountViewController: GenericContainerViewController {
    var currentWorkflowStep: MutableProperty<AuthorizationWorkflowStep>
    var authorizationViewController: MutableProperty<AuthorizationViewController?> = MutableProperty(nil)
    var splashScreenViewController: MutableProperty<SplashScreenViewController?> = MutableProperty(nil)
    var service: MutableProperty<Service?> = MutableProperty(nil)

    init?(currentState: AuthorizationWorkflowStep = .Splash,
          authVC: AuthorizationViewController.Type = AuthorizationViewController.self,
          splashScreenVC: SplashScreenViewController.Type = SplashScreenViewController.self) {

        authorizationViewController.value = authVC.init(nibName: nil, bundle: nil)!
        splashScreenViewController.value = splashScreenVC.init(nibName: nil, bundle: nil)!
        currentWorkflowStep = MutableProperty(currentState)

        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
 

    func viewControllerForStep(step: AuthorizationWorkflowStep) -> NSViewController? {
        switch (step) {
        case .Authorization:
            return self.authorizationViewController.value

        case .Splash:
            return self.splashScreenViewController.value

        default:
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    func configure() {
        d += childViewController <~ currentWorkflowStep.producer.map {
            [unowned self] step -> NSViewController? in
            return self.viewControllerForStep(step)
        }

        d += authorizationViewController !=> { [unowned self] in
            self.d += $0.service <~ self.service
        }
        d += splashScreenViewController !=> {[unowned self] in
            self.d += $0.service <~ self.service
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class AuthorizationViewController: OAuthWebViewController {
//when there is a service, it goes in this

    @IBOutlet weak var containerView: NSView!
    var service: MutableProperty<Service?> = MutableProperty(nil)
    var targetURL: NSURL = NSURL(string: "https://www.google.com/")!
    var webView: WKWebView!
    let loginSignal = Signal < AuthorizationWorkflowStep,
        NoError>.never
    var d = CompositeDisposable()
    deinit {
        d.dispose()
    }
    
    required override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var backButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false

        self.webView = WKWebView(frame: CGRectZero)
        self.containerView.addSubview(self.webView)
        constrain(self.webView) {
            view in view.size == view.superview!.size; view.center == view.superview!.center
        }
        self.webView.navigationDelegate = self
        d += self.service.producer.startWithNext {
            [unowned self] service in
            guard let service = service else {
                return
            }
            switch (service) {
            case let oauth1 as OAuth1:
                let oauth = oauth1.oauth1
                oauth.authorize_url_handler = self
                oauth.authorizeWithCallbackURL(oauth1.redirectURL, success: oauth1.authCallbackSuccess, failure: oauth1.authCallbackFailure)
            case let oauth2 as OAuth2:
                let oauth = oauth2.oauth2
                oauth.authorize_url_handler = self
                oauth.authorizeWithCallbackURL(oauth2.redirectURL, scope: "", state: "", success: oauth2.authCallbackSuccess, failure: oauth2.authCallbackFailure)
            default:
                ()
            }
            if let oauth = service as? OAuth {
            }


        }


    }

    @IBAction func backPressed(sender: AnyObject) {
        guard let pvc = self.parentViewController as? UnathorizedAccountViewController else {
            return
        }
        pvc.currentWorkflowStep.value = .Splash

    }

    override func handle(url: NSURL) {
        self.targetURL = url
        print("going ta: \(url)")
        let req = NSURLRequest(URL: targetURL)
        self.webView.loadRequest(req)
    }
}

extension AuthorizationViewController: WKNavigationDelegate {

    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.URL where url.host == "oauth.callback",
            let service = service.value {
            switch (service) {
            case is OAuth1:
                OAuth1Swift.handleOpenURL(url)
            case is OAuth2:
                OAuth2Swift.handleOpenURL(url)
            default:
                print("error")
            }

            decisionHandler(.Cancel)

            self.presentingViewController?.dismissViewController(self)
            return
        }

        decisionHandler(.Allow)
    }
}

class SplashScreenViewController: NSViewController {
    var service: MutableProperty<Service?> = MutableProperty(nil)
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var backgroundView: SolidView!
    @IBOutlet weak var logInButton: NSButton!
    var d = CompositeDisposable()
    deinit {
        d.dispose()
    }
    

    @IBAction func login(sender: AnyObject) {
        guard let pvc = self.parentViewController as? UnathorizedAccountViewController else {
            return
        }
        pvc.currentWorkflowStep.value = .Authorization
    }

    required override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "glanceSplash", bundle: nil)

    }

    
    override func viewDidLoad() {
        d += service !=> {[weak self]  in
            self?.titleLabel.stringValue = $0.name ?? ""
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
 
