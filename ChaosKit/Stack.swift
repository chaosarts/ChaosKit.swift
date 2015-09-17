//
//  Stack.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 11.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct Stack<T> : Collection, CountLimited {
	
	public typealias Element = T
	
	private var _array : [T] = []
	
	public var count : Int {get {return _array.count}}
	
	public let max : Int
	
	public var full : Bool {get {return count == max}}
	
	public var isEmpty : Bool {get {return count == 0}}
	
	public var top : T? {get {return isEmpty ? nil : _array[count - 1]}}
	
	public var bottom : T? {get {return isEmpty ? nil : _array[0]}}
	
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
	
	
	public mutating func push (element: T) -> Bool {
		if full {return false}
		_array.append(element)
		return true
	}
	
	
	public mutating func pop () -> T? {
		if isEmpty {return nil}
		return _array.removeLast()
	}
	
	
	public mutating func removeAll() -> [T] {
		let array = _array
		_array = []
		return array
	}
}


extension Stack : ArrayLiteralConvertible {
	public init(arrayLiteral elements: T...) {
		_array = elements
		max = Int.max
	}
}