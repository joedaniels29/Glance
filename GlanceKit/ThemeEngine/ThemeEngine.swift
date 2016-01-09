//
//  ThemeEngine.swift
//  Glance
//
//  Created by Joseph Daniels on 7/12/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
let _sharedInstance:ThemeEngine = ThemeEngine()
public class ThemeEngine {
    public class func sharedInstance()->ThemeEngine{
        return _sharedInstance
    }

    public var theme:AnyProperty<Theme>
    public init(){
        theme = anyProperty(BaseTheme())
    }

    
    
}