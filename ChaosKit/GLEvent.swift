//
//  GLEvent.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class GLEvent {
	
	var target : GLEventTarget?
	
	let type : String
	
	public init (_ type: String) {
		self.type = type
	}
}

public protocol GLEventListener {}

public protocol GLEventTarget {
	var listeners : [GLEventListener] {get}
	
	func add (listener l: GLEventListener)
	
	func remove (listener l: GLEventListener)
	
	func dispatch (event e: GLEvent)
	
	func notify (event e: GLEvent)
}


public class GLEventCenter {
	private var _stack : CKStack<GLEvent> = CKStack<GLEvent>()
	
	public var stack : CKStack<GLEvent> {get {return _stack}}
	
	public func push (event: GLEvent) {
		_stack.push(event)
	}
	
	public func handleEventStack () {
		var stack = _stack.removeAll()
		for event in stack {
			event.target?.notify(event: event)
		}
	}
}

