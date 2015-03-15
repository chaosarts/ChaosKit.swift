//
//  Event.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class Event {
	
	let target : EventTarget?
	
	let type : String
	
	public init (_ type: String) {
		self.type = type
	}
}

public protocol EventListener {}

public protocol EventTarget {
	var listeners : [EventListener] {get}
	
	func add (listener l: EventListener)
	
	func remove (listener l: EventListener)
	
	func dispatch (event e: Event)
	
	func notify (event e: Event)
}


public class EventCenter {
	private var _stack : CKStack<Event> = CKStack<Event>()
	
	public var stack : CKStack<Event> {get {return _stack}}
	
	public func push (event: Event) {
		_stack.push(event)
	}
	
	public func handleEventStack () {
		var stack = _stack.removeAll()
		for event in stack {
			event.target?.notify(event: event)
		}
	}
}

