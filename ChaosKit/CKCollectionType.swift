//
//  CKCollectionType.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.02.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public protocol CKCollectionType {
	typealias T = AnyObject
	
	var array : [T] {get}
	
	var count : Int {get}
	
	var empty : Bool {get}
}


public protocol CKCountLimited {
	typealias T = AnyObject
	
	var max : Int {get}
	
	var full : Bool {get}
	
	mutating func removeAll () -> [T]
}

public struct CKStack<T> : CKCollectionType, CKCountLimited {
	
	private var _array : [T] = []
	
	public var count : Int {get {return _array.count}}
	
	public let max : Int
	
	public var full : Bool {get {return count == max}}
	
	public var empty : Bool {get {return count == 0}}
	
	public var top : T? {get {return empty ? nil : _array[count - 1]}}
	
	public var bottom : T? {get {return empty ? nil : _array[0]}}
	
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
		if empty {return nil}
		return _array.removeLast()
	}
	
	
	public mutating func removeAll() -> [T] {
		var array = _array
		_array = []
		return array
	}
}


extension CKStack : ArrayLiteralConvertible {
	public init(arrayLiteral elements: T...) {
		_array = elements
		max = Int.max
	}
}



public struct CKQueue<T> : CKCollectionType, CKCountLimited {
	private var _array : [T] = []
	
	public var count : Int {get {return _array.count}}
	
	public let max : Int
	
	public var full : Bool {get {return count == max}}
	
	public var empty : Bool {get {return count == 0}}
	
	public var head : T? {get {return empty ? nil : _array[0]}}
	
	public var tail : T? {get {return empty ? nil : _array[count - 1]}}
	
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
		if empty {return nil}
		return _array.removeAtIndex(0)
	}
	
	
	public mutating func removeAll() -> [T] {
		var array = _array
		_array = []
		return array
	}
}


extension CKQueue : ArrayLiteralConvertible {
	public init(arrayLiteral elements: T...) {
		_array = elements
		max = Int.max
	}
}