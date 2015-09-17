//
//  GLSurfaceColor.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 08.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Provides the color values for each vertex of a geometry.
*/
public struct GLcolor<V: Vector> : GLAttribute {
	
	/// Provides the list of values
	public private(set) var values : [V]
	
	/// Indicates if the values shall be stored for dynamic or static draw
	public var dynamic : Bool = false
	
	/// Provides the size of a value per vertex
	public var size : Int {get {return V.elementCount}}
	
	
	/**
	Initializes the color with given values
	
	- parameter values: The values to use
	*/
	public init (_ values: [V]) {
		self.values = values
	}
	
	
	/**
	Initializes an empty color list
 	*/
	public init () {
		self.init ([])
	}
	
	
	/**
	Initializer for array literals
	*/
	public init (arrayLiteral elements: V...) {
		self.init(elements)
	}
	
	
	/**
	Returns the value of the vertex at given index as a list of float
	
	- parameter atIndex: The index of the vertex
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
}