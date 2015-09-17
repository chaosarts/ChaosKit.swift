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
This struct is used for shapes to describe their geometry. It's not neccessary
to set the indexlist explicitly. A index list is created simultanously as a new
vertex is added to this geometry. Depending on `sharedVertice`, the method
`getBufferData` returns the vertice as they are stored in `values` or in order
of `indexlist`.
*/
public struct GLgeom : GLGeometry, ArrayLiteralConvertible {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the vertex position to index
	private var _indexmap : [String : Int] = [String : Int]()
	
	/// Provides a list of positions of the geometry
	public private(set) var values : [vec3] = []
	
	/// Provides the size of a vertex
	public let size : Int = 3
	
	/// Provides the index list
	public private(set) var indexlist : [Int] = []
	
	/// Indicates whether the vertices change often or not
	public var dynamic : Bool = false
	
	/// Indicates if the vertice are shared (element array) or not (array)
	public var sharedVertice : Bool = false
	
	/// Provides the count of vertice
	public var count : Int {get {return indexlist.count}}
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides a list of line according to value/indexlist
	public var lines : [GLline] {get {return getLines(self)}}
	
	/// Provides a list of triangles according to value/indexlist
	public var triangles : [GLtriangle] {get {return GLtriangle.fromGeometry(self)}}
	
	
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
	
	- parameter index: The index of the vertex to fetch
	- returns: The vertex position
	*/
	public subscript (index: Int) -> vec3 {
		get {return values[indexlist[index]]}
		set {
			var newIndex : Int? = _indexmap[newValue.description]
			if nil == newIndex {
				newIndex = append(newValue)
			}
			indexlist[index] = newIndex!
		}
	}
	
	
	/**
	Returns the index of the position in the geometry
	
	- parameter value: The position vector to get the index from
	- returns: The index
	*/
	public subscript (value: vec3) -> Int? {
		get {return indexOf(value)}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the geoemtry with passed values
	*/
	public init (_ values: [vec3]) {
		for value in values {
			append(value)
		}
	}
	
	
	/**
	Initializer from ArrayLiteralConvertiable protocol
	
	- parameter arrayLiteral:
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
	
	
	public init (_ geom: GLGeometry) {
		self.init(geom.values)
		self.sharedVertice = geom.sharedVertice
		self.dynamic = geom.dynamic
	}
	
	
	/**
	Returns the value according to the
	
	- parameter index: The index of the value to fetch
	:return: The vector at given index
	*/
	public func getBufferData (atIndex index: Int) -> [GLfloat] {
		return sharedVertice ? values[index].array : values[indexlist[index]].array
	}
	
	
	/**
	Appends a new value to the geometry
	
	- parameter value: The value to append
 	*/
	public mutating func append (value: vec3) -> Int {
		var index : Int? = _indexmap[value.description]
		
		// Value is not in list yet
		if nil == index {
			index = values.count
			_indexmap[value.description] = index!
			values.append(value)
		}
		
		indexlist.append(index!)
		return index!
	}
	
	
	/**
	Adds one or mor values to the geometry
	
	- parameter values: The list of values to add
	*/
	public mutating func extend (values : [vec3]) {
		for value in values {
			append(value)
		}
	}
	
	
	public func indexOf (value: vec3) -> Int? {
		return _indexmap[value.description]
	}
}