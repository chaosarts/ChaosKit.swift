//
//  GLgeom.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 19.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/*
|--------------------------------------------------------------------------
| Structs
|--------------------------------------------------------------------------
*/

/**
This struct is used for shapes to describe their geometry. No vertex added to 
this struct is stored twice. Instead an indexlist is used to indicate the order
of vertice for vertex stream. For `glDrawElements` use the order of values as it is
stored in the `values` property to the buffer and pass the `indexlist` property.
*/
public struct GLgeom : GLAttribute, ArrayLiteralConvertible {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the vertex position to index
	private var _indexMap : [String : Int] = [String : Int]()
	
	/// Provides a list of positions of the geometry
	public private(set) var values : [vec3] = []
	
	/// Indicates whether the vertices change often or not
	public var dynamic : Bool = false
	
	/// Provides the size of a vertex
	public let size : Int = 3
	
	/// Provides the index list
	public private(set) var indexlist : [Int] = []
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides a list of line according to value/indexlist
	public var lines : [GLline] {
		get {
			var lines : [GLline] = []
			var line : GLline? = getLine(atIndex: 0)
			
			while line != nil {
				lines.append(line!)
				line = getLine(atIndex: lines.count)
			}
			return lines
		}
	}
	
	/// Provides a list of triangles according to value/indexlist
	public var triangles : [GLtriangle] {
		get {
			var triangles : [GLtriangle] = []
			var triangle : GLtriangle? = getTriangle(atIndex: 0)
			
			while nil != triangle {
				triangles.append(triangle!)
				triangle = getTriangle(atIndex: triangles.count)
			}
			
			return triangles
		}
	}
	
	
	// SUBSCRIPTS
	// ++++++++++
	
	/** 
	Appends a new value to the geometry
	*/
	public subscript () -> vec3 {
		get {return vec3()}
		set {append(newValue)}
	}
	
	
	/** 
	Returns the vertex at given index according to indexlist
	
	:param: index The index of the vertex to fetch
	:returns: The vertex position
	*/
	public subscript (index: Int) -> vec3 {
		get {return values[indexlist[index]]}
		set {
			var newIndex : Int? = _indexMap[newValue.description]
			if nil == newIndex {
				newIndex = append(newValue)
			}
			indexlist[index] = newIndex!
		}
	}
	
	
	/**
	Returns the index of the position in the geometry
	
	:param: value The position vector to get the index from
	:returns: The index
	*/
	public subscript (value: vec3) -> Int? {
		get {return _indexMap[value.description]}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the geoemtry with passed values
	*/
	public init (_ values: [vec3]) {
		self.values = values
	}
	
	
	/**
	Initializer from ArrayLiteralConvertiable protocol
	
	:param: arrayLiteral
	*/
	public init(arrayLiteral elements: vec3...) {
		self.init(elements)
	}
	
	
	/**
	Default intializer
	*/
	public init () {
		self.init([])
	}
	
	
	/**
	Returns the value according to the
	
	:param: index The index of the value to fetch
	:return: The vector at given index
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
	
	
	/**
	Appends a new value to the geometry
	
	:param: value The value to append
 	*/
	public mutating func append (value: vec3) -> Int {
		var index : Int? = _indexMap[value.description]
		
		// Value is not in list yet
		if nil == index {
			index = values.count
			_indexMap[value.description] = index!
			values.append(value)
		}
		
		indexlist.append(index!)
		return index!
	}
	
	
	/**
	Adds one or mor values to the geometry
	
	:param: values The list of values to add
	*/
	public mutating func extend (values : [vec3]) {
		for value in values {
			append(value)
		}
	}
	
	
	/**
	Returns the triangle with given index
	
	:param: atIndex The index of the triangle
	:returns: The triangle
	*/
	public func getLine (atIndex index: Int) -> GLline? {
		let startIndex : Int = index * 2
		if startIndex + 1 >= indexlist.count {return nil}
		return GLline(self[startIndex], self[startIndex + 1])
	}
	
	
	/**
	Returns the triangle with given index
	
	:param: atIndex The index of the triangle
	:return: The triangle
	*/
	public func getTriangle (atIndex index: Int) -> GLtriangle? {
		let startIndex : Int = index * 3
		if startIndex + 2 >= indexlist.count {return nil}
		return GLtriangle(self[startIndex], self[startIndex + 1], self[startIndex + 2])
	}
	
	
	/**
	Returns all lines, to which the given point belongs to
	
	:param: forPoint The point for which to fetch the lines
	:return: A list of all lines including the passed point
	*/
	public func getLines (forPoint point: vec3) -> [GLline] {
		let index : Int? = _indexMap[point.description]
		if nil == index {return []}
		
		var lines : [GLline] = []
		for i in 0..<indexlist.count {
			if indexlist[i] != index! {continue}
			let firstIndex : Int = i - i % 2
			if firstIndex + 1 >= indexlist.count {break}
			lines.append(GLline(self[firstIndex], self[firstIndex + 1]))
		}
		
		return lines
	}
	
	
	/**
	Returns all lines, to which the given point belongs to
	
	:param: forPoint The point for which to fetch the lines
	:return: A list of all lines including the passed point
	*/
	public func getTriangles (forPoint point: vec3) -> [GLtriangle] {
		let index : Int! = _indexMap[point.description]
		if nil == index {return []}
		
		var triangles : [GLtriangle] = []
		for i in 0..<indexlist.count {
			if indexlist[i] != index {continue}
			let firstIndex : Int = i - i % 3
			if firstIndex + 2 >= indexlist.count {break}
			triangles.append(GLtriangle(self[firstIndex], self[firstIndex + 1], self[firstIndex + 2]))
		}
		return triangles
	}
}