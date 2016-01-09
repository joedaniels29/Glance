//
//  NSEdgeInsets+custom.swift
//  Glance
//
//  Created by Joseph Daniels on 8/6/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
extension NSEdgeInsets{
    init(inset:CGFloat){
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}