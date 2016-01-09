//: Playground - noun: a place where people can play

import Cocoa

import ReactiveCocoa


 final class Atomic<T> {
    private var spinlock = OS_SPINLOCK_INIT
    private var _value: T
    
    /// Atomically gets or sets the value of the variable.
    var value: T {
        get {
            lock()
            let v = _value
            unlock()
            
            return v
        }
        
        set(newValue) {
            lock()
            _value = newValue
            unlock()
        }
    }
    
    /// Initializes the variable with the given initial value.
    init(_ value: T) {
        _value = value
    }
    
    private func lock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockLock)
    }
    
    private func unlock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockUnlock)
    }
    
    /// Atomically replaces the contents of the variable.
    ///
    /// Returns the old value.
    func swap(newValue: T) -> T {
        return modify { _ in newValue }
    }
    
    /// Atomically modifies the variable.
    ///
    /// Returns the old value.
    func modify(@noescape action: T -> T) -> T {
        lock()
        let oldValue = _value
        _value = action(_value)
        unlock()
        
        return oldValue
    }
    
    /// Atomically performs an arbitrary action using the current value of the
    /// variable.
    ///
    /// Returns the result of the action.
    func withValue<U>(@noescape action: T -> U) -> U {
        lock()
        let result = action(_value)
        unlock()
        
        return result
    }
}
var str = "Hello, playground"
/// Maps each value in the signal to a new value.
extension SignalType where T: SignalType, E == T.E {
	func merge() -> Signal<T.T, E> {
    	return Signal<T.T, E> { relayObserver in
        	let inFlight = Atomic(1)
	        let decrementInFlight: () -> () = {
    	        let orig = inFlight.modify { $0 - 1 }
        	    if orig == 1 {
            	    sendCompleted(relayObserver)
	            }
    	    }
        
     	   let disposable = CompositeDisposable()
        	self.observe { event in
            	switch event {
	            case let .Next(signal):
    	            signal.observe({ (event) -> () in
        	                switch event {
            	            case .Completed, .Interrupted:
                	            decrementInFlight()
                    	    default:
                        	    relayObserver(event)
                        	}
	                })
    	            
        	    case let .Error(error):
            	    sendError(relayObserver, error)
                
	            case .Completed:
    	            decrementInFlight()
                
        	    case .Interrupted:
            	    sendInterrupted(relayObserver)
	            }
    	    }
        	return disposable
	    }
    }
}





let (producerA, lettersSink) = Signal<String, NoError>.pipe()
let (producerB, numbersSink) = Signal<String, NoError>.pipe()
let (signal, sink) = Signal<String, NoError>.pipe()
//let (signal, sink) = Signal<Signal<String, NoError>, NoError>.pipe()
producerA.observeNext({ s in
    sendNext(sink, s)
    return ()
})
producerB.observeNext({ s in
    sendNext(sink, s)
    return ()
})
signal.observeNext({print($0)})

//sendNext(sink, producerA)
//sendNext(sink, producerB)
//sendCompleted(sink)

sendNext(lettersSink, "a")    // prints "a"
sendNext(numbersSink, "1")    // prints "1"
sendNext(lettersSink, "b")    // prints "b"
sendNext(numbersSink, "2")    // prints "2"
sendNext(lettersSink, "c")    // prints "c"
sendNext(numbersSink, "3")



