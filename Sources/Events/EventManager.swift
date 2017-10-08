
///
/// EventManager.swift
/// Events
///
/// Create custom events
///
/// - Author: Robin Walter
/// - License: MIT License
/// - Version: 1.1.3
/// - Note: Original code from Stephen Haney
/// - SeeAlso: https://github.com/StephenHaney/Swift-Custom-Events
///

import Foundation

/**
 The EventManager manages the events

 - Version: 1.1.3
 */
class EventManager {

    /**
     Stores the events in a `Dictonary` as `String` and the `func`s/closures in an Array

     - Since: 1.0.0
     */
    var listeners: Dictionary< String, NSMutableArray >

    /**
     Stores the performed event listeners

     - Since: 1.0.0
     */
    var done: Array< String >
    
    /**
     Initializes the Event Manager
     
     - Since: 1.1.2
     */
    init() {
        
        listeners = Dictionary< String, NSMutableArray >()
        done = [ String ]()
        
    }

    /**
     Add an action to the event

     - Since: 1.0.0

     - Parameter tag: The event name.
     - Parameter action: The callback to perform.
     - Parameter priority: The priority of the callback.
     */
    func addListener( tag: String, action: @escaping ( () -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )
        
        if let listeners = self.listeners[ tag ] {
            
            listeners.add( callback )
            
        }
        else {
            
            self.listeners[ tag ] = [ callback ] as NSMutableArray
            
        }

        return self.listeners[ tag ]!.index( of: callback )

    }

    /**
    Add an action to the event

    - Since: 1.0.0

     - Parameter tag: The event name.
     - Parameter action: The callback to perform.
     - Parameter priority: The priority of the callback.
     */
    func addListener( tag: String, action: @escaping ( ( Any? ) -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )

        if let listeners = self.listeners[ tag ] {
            
            listeners.add( callback )
            
        }
        else {
            
            self.listeners[ tag ] = [ callback ] as NSMutableArray
            
        }

        return self.listeners[ tag ]!.index( of: callback )

    }

    /**
     Add an action to the event

     - Since: 1.0.0

     - Parameter tag: The event name.
     - Parameter action: The callback to perform.
     - Parameter priority: The priority of the callback.
     */
    func addListener( tag: String, action: @escaping ( ( Any... ) -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )

        if let listeners = self.listeners[ tag ] {
            
            listeners.add( callback )
            
        }
        else {
            
            self.listeners[ tag ] = [ callback ] as NSMutableArray
            
        }

        return self.listeners[ tag ]!.index( of: callback )

    }

    /**
     Remove event listener

     - Since: 1.0.0
     - Warning: **It's not possible to remove a listener when the event was already triggered!**

     - Parameter tag: The event name.
     - Parameter index: Optional. The index of the listener to remove. Default `nil`.
     */
    func removeListener( tag: String, index: Int? = nil ) {

        if index != nil {

            self.listeners[ tag ]?.remove( index as Any )

        }
        else {

            self.listeners.removeValue( forKey: tag )

        }

    }

    /**
     Clear the Event Listener Manager

     - Since: 1.0.0
     */
    func clearManager() {

        self.listeners.removeAll()

    }

    /**
     Triggers an event

     - Since: 1.0.0

     - Parameter tag: The event name.
     - Parameter param: Optional. The parameter given to the callbacks.
     */
    func trigger( tag: String, param: Any? ) {

        if self.done.index( of: tag ) == nil {
            
            self.sort( listeners: &self.listeners[ tag ]! )

            if let listeners = self.listeners[ tag ] {

                for actionObject in listeners {
                    
                    if let actionToPerform = actionObject as? EventListenerAction {
                        
                        if let action = actionToPerform.actionWithParam {
                            
                            action( param )
                            
                        }
                        else if let action = actionToPerform.action {
                            
                            action()
                            
                        }
                        
                    }

                }

                // Remove the listeners to avoid a new trigger
                // and add the tag to `done`
                self.removeListener( tag: tag )
                self.done.append( tag )

            }

        }

    }

    /**
     Triggers an event

     - Since: 1.0.0

     - Parameter tag: The event name.
     - Parameter params: The parameters given to the callbacks.
     */
    func trigger( tag: String, params: Any... ) {

        if self.done.index( of: tag ) == nil {
            
            self.sort( listeners: &self.listeners[ tag ]! )

            if let listeners = self.listeners[ tag ] {

                for actionObject in listeners {
                    
                    if let actionToPerform = actionObject as? EventListenerAction {
                        
                        if let action = actionToPerform.actionWithMultipleParams {
                            
                            action( params )
                            
                        }
                        
                    }

                }

                // Remove the listeners to avoid a second trigger
                // and add the tag to `done`
                self.removeListener( tag: tag )
                self.done.append( tag )

            }

        }

    }
    
    /**
     Check whether an event was already triggered
     
     - Since: 1.1.3
     
     - Parameter tag: The event name.
     */
    func isDone( tag: String ) -> Bool {
        
        if self.done.index( of: tag ) != nil {
            
            return true
            
        }
        else {
            
            return false
            
        }
        
    }

    /**
     Sort the listeners by priority

     - Since: 1.0.0
     - SeeAlso: https://gist.github.com/robinwalterfit/60a42c388d35b66cba7cf7864bc0fb98

     - Parameter listeners: The listeners of the event to sort.
     */
    func sort( listeners: inout NSMutableArray ) {

        if listeners.count > 1 {

            var left  = NSMutableArray()
            var right = NSMutableArray()

            guard let pivot = listeners[ 0 ] as? EventListenerAction else {
                
                return
                
            }

            for i in 1...( listeners.count - 1 ) {

                guard let listener = listeners[ i ] as? EventListenerAction else {
                    
                    return
                    
                }

                if listener.priority < pivot.priority {

                    left.add( listener )

                }
                else {

                    right.add( listener )

                }

            }

            listeners.removeAllObjects()

            self.sort( listeners: &left )
            self.sort( listeners: &right )

            listeners.addObjects( from: left as! [ Any ] )
            listeners.add( pivot )
            listeners.addObjects( from: right as! [ Any ] )

        }

    }

}
