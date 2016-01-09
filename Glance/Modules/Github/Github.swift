//
// Created by Joseph Daniels on 9/30/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
class Github {
    var authorizationStatus: MutableProperty<AuthorizationStatus> = MutableProperty(.Unauthorized)
    var baseURL = NSURL(string:"https://api.github.com/")!


}
