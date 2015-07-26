
//
//  GLconstattrib.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 24.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
This struct is 'constant' for one shape. It always returns the same value for each
vertex of a shape.
*/
public struct GLconstattrib<V: Vector> : GLAttribute {
	
	/// Provides the value to return for `getValue(atIndex index: Int)`
	public var value : V
	
	/// Indicates if the value will be buffered for dynamic or static draw
	public var dynamic : Bool = false
	
	/// Provides the count per vertex get by `getValue(atIndex index: Int)`
	public var size : Int {get {return V.elementCount}}
	
	
	/**
	Initializes the constant attribute with given value
	
	:param: value The value to use for this constant
	*/
	public init (_ value: V) {
		self.value = value
	}
	
	
	/**
	Initializes the attribute with the default vector as value
	*/
	public init () {
		self.init(V())
	}
	
	
	/**
	Returns always the same float list for each index
	
	:param: index The index of the vertex to fetch the vertex attribute value
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return value.array
	}
}


public typealias GLconstattrib2 = GLconstattrib<vec2>
public typealias GLconstattrib3 = GLconstattrib<vec3>
public typealias GLconstattrib4 = GLconstattrib<vec4>