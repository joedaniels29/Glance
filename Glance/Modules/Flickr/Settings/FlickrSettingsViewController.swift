//
// Created by Joseph Daniels on 7/17/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit

class FlickrSettingsViewController : OAuthServiceSettingsContainerController {
    
    convenience init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.init(service: Flickr.service)
    }
    override init?(service:Service){
        super.init(service:service)
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.service.value = Flickr.service
    }
    
}
