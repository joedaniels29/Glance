//
//  ServiceSettingsContainerController.swift
//  Glance
//
//  Created by Joseph Daniels on 10/2/15.
//  Copyright © 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import Cartography
import Alamofire
import ReactiveCocoa
import OAuthSwift

class ServiceSettingsController: NSViewController{
    var service: MutableProperty<Twitter?> = MutableProperty( nil)
//    override func loadView() {
//        self.view = NSView(frame:CGRect(x: 0, y: 0, width: 400, height: 700))
//        
//    }
    
    override func viewDidLoad() {
        TwitterRouter.StatusesHomeTimeline.tweets() => { t in
            print(t)
        }
    }
    var d = CompositeDisposable()
    deinit {
        d.dispose()
    }

    init?(service:Service){
        super.init(nibName: nil, bundle: nil)
        d += self.service !=> { [unowned self] in self.identifier = $0.name}
    }

    convenience override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.init(service:Twitter.service)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }


}





