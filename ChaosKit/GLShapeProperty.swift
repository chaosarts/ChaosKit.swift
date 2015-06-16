//
//  GLShapeProperty.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 09.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/** 
Protocol to describe shape properties such as geometry, colors, normals, texcoords
*/
public protocol GLShapeProperty : GLBufferable {}


/**
General shape property struct, that provides the data as a list of vectors. This is
needed, when a shape needs another value for each vertex, like normals or texture coordinates.
*/
public struct GLShapePropertyArray<V: Vector> : GLShapeProperty, ArrayLiteralConvertible  {
	
	/// The values as a list of vectors
	public var values : [V] = []
	
	/// Provids the size per vertex
	public var size : Int {get {return V.elementCount}}
	
	/// Indicates how often single values will change
	public var dynamic : Bool = false
	
	/// Subscript access to append values
	public subscript () -> V {
		get {return V()}
		set {values.append(newValue)}
	}
	
	/// Returns one value as a float list
	public subscript (index: Int) -> [GLfloat] {
		get {return values[index].array}
	}
	
	
	/// Initializes an empty property
	public init () {
		self.init(values: [])
	}
	
	
	/// Initializes the property with given values
	public init (values: [V]) {
		self.values = values
	}
	
	
	/// ArrayLiteralConvertible initializer
	public init(arrayLiteral elements: V...) {
		self.init(values: elements)
	}
}


/**
General shape property struct that provides one single value. This is useful for
Shapes with one surface color. The struct reutrns always the same value for each
subscript index access. This may safe some memory.
*/
public struct GLShapePropertySingleValue<V: Vector> : GLShapeProperty, ArrayLiteralConvertible {
	
	/// Provides the single value, which will be returned 
	/// as array on subscipt access
	public var value : V
	
	/// The size of the value
	public var size : Int {get {return V.elementCount}}
	
	/// Indicates how often single values will change
	public var dynamic : Bool = false
	
	
	/// Returns the single value as float list
	public subscript (index: Int) -> [GLfloat] {
		get {return value.array}
	}
	
	
	/// Initializes the property with the zero vector
	public init () {
		self.init(value: V())
	}
	
	
	/// Initializes the property with passed vector
	public init (value: V) {
		self.value = value
	}
	
	/// ArrayLiteralConvertible initializer
	public init(arrayLiteral elements: GLfloat...) {
		self.init(value: V(elements))
	}
}