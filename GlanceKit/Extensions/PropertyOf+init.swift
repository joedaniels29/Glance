//
//  AnyProperty+init.swift
//  Glance
//
//  Created by Joseph Daniels on 8/3/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
extension AnyProperty{
    init(ival:T, s:SignalProducer<T, NoError>){
        var p = MutableProperty(ival)
        p <~ s
        self.init(p)
    }
}