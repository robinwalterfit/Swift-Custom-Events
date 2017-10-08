
///
/// EventListenerAction.swift
/// Events
///
/// Create custom events
///
/// - Author: Robin Walter
/// - License: MIT License
/// - Version: 1.1.4
/// - Note: Original code from Stephen Haney
/// - SeeAlso: https://github.com/StephenHaney/Swift-Custom-Events
///

import Foundation

/**
    The Object to hold actions in the Array

    - Version: 1.0.0
*/
class EventListenerAction {

    /**
        Declares an action that takes no parameters

        - Since: 1.0.0
    */
    let action: ( () -> () )?

    /**
        Declares an action that can optionally take a parameter

        - Since: 1.0.0
    */
    let actionWithParam: ( ( Any? ) -> () )?

    /**
        Declares an action that takes multiple parameters

        - Since: 1.0.0
    */
    let actionWithMultipleParams: ( ( Any... ) -> () )?

    /**
        The priority of the callback

        - Since: 1.0.0
    */
    let priority: UInt8

    /**
        Initializes an action that takes no parameters

        - Since: 1.0.0

        - Parameter callback: The action to call
        - Parameter priority: The priority of the callback
    */
    init( callback: @escaping ( () -> () ), _ priority: UInt8 ) {

        self.action                   = callback
        self.actionWithParam          = nil
        self.actionWithMultipleParams = nil

        self.priority = priority

    }

    /**
        Initializes an action that can optionally take a parameter

        - Since: 1.0.0

        - Parameter callback: The action to call
        - Parameter priority: The priority of the callback
    */
    init( callback: @escaping ( ( Any? ) -> () ), _ priority: UInt8 ) {

        self.action                   = nil
        self.actionWithParam          = callback
        self.actionWithMultipleParams = nil

        self.priority = priority

    }

    /**
        Initializes an action that takes multiple parameters

        - Since: 1.0.0

        - Parameter callback: The action to call
        - Parameter priority: The priority of the callback
    */
    init( callback: @escaping ( ( Any... ) -> () ), _ priority: UInt8 ) {

        self.action                   = nil
        self.actionWithParam          = nil
        self.actionWithMultipleParams = callback

        self.priority = priority

    }

}
