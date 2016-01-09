//
// Created by Joseph Daniels on 11/20/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa

extension PropertyType where Self.Value : OptionalType {
    var valueProducer:SignalProducer<Self.Value.Wrapped, NoError>{
        
        return self.producer.ignoreNil()
    }

    
}


infix operator !=> {
//    precedence 100
//    associativity 100
}

infix operator => {
//    precedence 100
//    associativity 100
}
infix operator =-= {
    precedence 200
//    associativity 100
}


infix operator > {
//    precedence 100
//    associativity 100
}

func =>< C1: PropertyType>(lhs:C1, rhs: C1.Value -> ()) -> Disposable {
    return lhs.producer.startWithNext(rhs)
}
func !=>< C1: PropertyType, C2 where C1.Value == C2?>(lhs:C1, rhs:C2 -> ())-> Disposable{
    return lhs.valueProducer.startWithNext(rhs)
}
func =>< C1: SignalProducerType>(lhs:C1, rhs:C1.Value -> ()) -> Disposable{
    return lhs.startWithNext(rhs)
}

func =-=< C1: SignalProducerType, C2, U where C1.Value == C2> (lhs:C1, rhs:C2 -> SignalProducer<U, C1.Error>) -> SignalProducer<U, C1.Error>{
    return lhs.flatMap(.Latest, transform:rhs)
}
func > < C1: SignalProducerType, C2, U where C1.Value == C2> (lhs:C1, rhs:C2 -> U ) -> SignalProducer<U, C1.Error>{
    return lhs.map(rhs)
}
