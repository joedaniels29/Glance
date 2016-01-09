//
//  AnyProperty.swift
//  Glance
//
//  Created by Joseph Daniels on 7/18/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
public func anyProperty<T>(t:T) -> AnyProperty<T> {return AnyProperty(ConstantProperty(t))}
