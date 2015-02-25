//
//  CKOpenGLEvent.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 21.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Cocoa

public class CKOpenGLEvent {
	
	let target : CKOpenGLEventTarget?
	
	let type : String
	
	public init (_ type: String) {
		self.type = type
	}
}

public protocol CKOpenGLEventListener {}

public protocol CKOpenGLEventTarget {
	var listeners : [CKOpenGLEventListener] {get}
	
	func add (listener l: CKOpenGLEventListener)
	
	func remove (listener l: CKOpenGLEventListener)
	
	func dispatch (event e: CKOpenGLEvent)
	
	func notify (event e: CKOpenGLEvent)
}


public class CKOpenGLEventCenter {
	private var _stack : CKStack<CKOpenGLEvent> = CKStack<CKOpenGLEvent>()
	
	public var stack : CKStack<CKOpenGLEvent> {get {return _stack}}
	
	public func push (event: CKOpenGLEvent) {
		_stack.push(event)
	}
	
	public func handleEventStack () {
		var stack = _stack.removeAll()
		for event in stack {
			event.target?.notify(event: event)
		}
	}
}

