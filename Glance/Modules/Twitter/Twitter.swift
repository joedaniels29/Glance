//
// Created by Joseph Daniels on 9/30/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa

//Root
//#326ada	(50,106,218)
//background
//#d4d8d4	(212,216,212)

//shadow
//#433e90	(67,62,144)
//dark Grey
//#a19c9c	(161,156,156)
//light Grey
//#d2d2d2	(210,210,210)


class Twitter {
    var authorizationStatus: MutableProperty<AuthorizationStatus> = MutableProperty(.Unauthorized)
    var baseURL = NSURL(string: "https://api.twitter.com/1.1/")!
}

