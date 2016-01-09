//
// Created by Joseph Daniels on 12/19/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol Chronological {
    typealias ModelType
    typealias Models = [ModelType]


    var models: AnyProperty<Models> { get }
}