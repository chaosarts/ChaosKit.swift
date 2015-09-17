//
//  Queue.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct Queue<T> : Collection, CountLimited {
	private var _array : [T] = []
	
	public var count : Int {get {return _array.count}}
	
	public let max : Int
	
	public var full : Bool {get {return count == max}}
	
	public var isEmpty : Bool {get {return count == 0}}
	
	public var head : T? {get {return isEmpty ? nil : _array[0]}}
	
	public var tail : T? {get {return isEmpty ? nil : _array[count - 1]}}
	
	public var array : [T] {get {return _array}}
	
	
	public init () {
		max = Int.max
	}
	
	
	public init (_ max: Int) {
		self.max = max
	}
	
	public init (_ elements: [T], _ max: Int = Int.max) {
		self.max = max
		_array = elements
	}
	
	
	public mutating func enqueue(element: T) -> Bool {
		if full {return false}
		_array.append(element)
		return true
	}
	
	
	public mutating func enqueue(elements: [T]) {
		for element in elements {
			enqueue(element)
		}
	}
	
	
	public mutating func dequeue() -> T? {
		if isEmpty {return nil}
		return _array.removeAtIndex(0)
	}
	
	
	public mutating func removeAll() -> [T] {
		let array = _array
		_array = []
		return array
	}
}


extension Queue : ArrayLiteralConvertible {
	public init(arrayLiteral elements: T...) {
		_array = elements
		max = Int.max
	}
}