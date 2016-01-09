//: Playground - noun: a place where people can play
import Cocoa
import ReactiveCocoa

var str = "Hello, playground"


var propA = MutableProperty("")
var propB = MutableProperty("")
var propC = MutableProperty("")
propB <~ propA
propB.producer.startWithNext({ _ in
    propC <~ propB
})

propA.producer.startWithNext{print($0)}
