
///
/// EventManager.swift
/// Events
///
/// Create custom events
///
/// - Author: Robin Walter
/// - License: MIT License
/// - Version: 1.0.0
/// - Note: Original code from Stephen Haney
/// - SeeAlso: https://github.com/StephenHaney/Swift-Custom-Events
///

import Foundation

/**
    The EventManager manages the events

    - Version: 1.0.0
*/
class EventManager {

    /**
        Stores the events in a `Dictonary` as `String` and the `func`s/closures in an Array

        - Since: 1.0.0
    */
    static var listeners = [ String: [ EventListenerAction ] ]()

    /**
        Stores the performed event listeners

        - Since: 1.0.0
    */
    static var done = [ String ]()

    /**
        Add an action to the event

        - Since: 1.0.0

        - Parameter tag: The event name
        - Parameter action: The callback to perform
        - Parameter priority: The priority of the callback
    */
    static func addListener( tag: String, action: @escaping ( () -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )

        self.listeners[ tag ].append( callback )

        self.sort( listeners: self.listeners[ tag ] )

        return self.listeners[ tag ].index( of: callback )

    }

    /**
        Add an action to the event

        - Since: 1.0.0

        - Parameter tag: The event name
        - Parameter action: The callback to perform
        - Parameter priority: The priority of the callback
    */
    static func addListener( tag: String, action: @escaping ( ( Any? ) -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )

        self.listeners[ tag ].append( callback )

        self.sort( listeners: self.listeners[ tag ] )

        return self.listeners[ tag ].index( of: callback )

    }

    /**
        Add an action to the event

        - Since: 1.0.0

        - Parameter tag: The event name
        - Parameter action: The callback to perform
        - Parameter priority: The priority of the callback
    */
    static func addListener( tag: String, action: @escaping ( ( Any... ) -> () ), priority: UInt8 = 10 ) -> Int {

        let callback = EventListenerAction( callback: action, priority )

        self.listeners[ tag ].append( callback )

        self.sort( listeners: self.listeners[ tag ] )

        return self.listeners[ tag ].index( of: callback )

    }

    /**
        Remove event listener

        - Since: 1.0.0

        - Parameter tag: The event name
        - Parameter index: The index of the listener to remove
    */
    static func removeListener( tag: String, index: Int? ) {

        if index {

            self.listeners[ tag ].remove( at: index )

        }
        else {

            self.listeners.removeValue( forKey: tag )

        }

    }

    /**
        Clear the Event Listener Manager

        - Since: 1.0.0
    */
    static func clearManager() {

        self.listeners.removeAll()

    }

    /**
        Triggers an event

        - Since: 1.0.0

        - Parameter tag: The event name
        - Parameter param: Optional. The parameter given to the callbacks
    */
    static func trigger( tag: String, param: Any? ) {

        if !self.done.index( of: tag ) {

            if !self.listeners[ tag ].isEmpty {

                for action in self.listeners[ tag ] {

                    if action.actionWithParam {

                        action.actionWithParam( param )

                    }
                    else {

                        action.actionWithParam()

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

        - Parameter tag: The event name
        - Parameter params: The parameters given to the callbacks
    */
    static func trigger( tag: String, params: Any... ) {

        if !self.done.index( of: tag ) {

            if !self.listeners[ tag ].isEmpty {

                for action in self.listeners[ tag ] {

                    action.actionWithMultipleParams( params )

                }

                // Remove the listeners to avoid a second trigger
                // and add the tag to `done`
                self.removeListener( tag: tag )
                self.done.append( tag )

            }

        }

    }

    /**
        Sort the listeners by priority

        - Since: 1.0.0
        - SeeAlso: https://gist.github.com/robinwalterfit/60a42c388d35b66cba7cf7864bc0fb98

        - Parameter listeners: The listeners of the event to sort
    */
    static func sort( listeners: inout [ EventListenerAction ] ) {

        if listeners.count > 1 {

            var left  = [ EventListenerAction ]()
            var right = [ EventListenerAction ]()

            let pivot = listeners[ 0 ]

            for i in 1...( listeners.count - 1 ) {

                let listener = listeners[ i ]

                if listener.priority < pivot.priority {

                    left.append( listener )

                }
                else {

                    right.append( listener )

                }

            }

            listeners.removeAll()

            self.sort( listeners: &left )
            self.sort( listeners: &right )

            listeners += left
            listeners.append( pivot )
            listeners += right

        }

    }

}
