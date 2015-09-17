//
//  GLvarattrib.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 25.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct to provide attribute data
*/
public struct GLvarattrib<V: Vector> : GLAttribute, ArrayLiteralConvertible {
	
	/// Provides the list of values per vertex
	public private(set) var values : [V]
	
	/// Indicates if the attribute is dynamic
	public var dynamic : Bool = false
	
	/// Provides the size one value of a vertex
	public var size : Int {get {return V.elementCount}}
	
	
	/**
	Initializes the attribute with given values
	
	- parameter values: The values to us for the attribute
	*/
	public init (_ values: [V]) {
		self.values = values
	}
	
	
	/**
	Initializes an empty attribute list
	*/
	public init () {
		self.init([])
	}
	
	
	/**
	Initializer for array literals
	
	- parameter arrayLiteral:
	*/
	public init (arrayLiteral elements: V...) {
		self.init(elements)
	}
	
	
	/**
	Returns the value for one vertex of given index for buffering
	
	- parameter atIndex: the index of the vertex to fetch data from
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
	
	
	
	public mutating func append (value: V) {
		values.append(value)
	}
	
	
	public mutating func extend (values: [V]) {
		for val in values {
			append(val)
		}
	}
	
	
	public mutating func extend (values: V...) {
		extend(values)
	}
}



public typealias GLvarattrib2 = GLvarattrib<vec2>
public typealias GLvarattrib3 = GLvarattrib<vec3>
public typealias GLvarattrib4 = GLvarattrib<vec4>