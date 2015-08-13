//
//  GLparallelogram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 28.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLparallelogram : GLGeometry {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides a list of positions of the geometry
	public private(set) var values : [vec3] = []
	
	/// Provides the index list
	public private(set) var indexlist : [Int] = []
	
	/// Indicates if the vertice are shared (element array) or not (array)
	public var sharedVertice : Bool = false
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the size of a vertex
	public var size : Int {get {return 3}}
	
	/// Indicates whether the vertices change often or not
	public var dynamic : Bool {get {return false}}
	
	/// Provides the count of vertice, which are uploaded to the buffer,
	/// depending on `sharedVertice`
	public var count : Int {get {return sharedVertice ? values.count : indexlist.count}}
	
	/// Provides a list of line according to value/indexlist
	public var lines : [GLline] {get {return getLines(self as GLGeometry)}}
	
	/// Provides a list of triangles according to value/indexlist
	public var triangles : [GLtriangle] {get {return GLtriangle.fromGeometry(self as GLGeometry)}}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/**
	Initializes the parallelogram with three vectors. The resulting geometry consists
	of the points at p, p + s,  p +s + t and p + t
	
	:param: p The position to start the parallelogram from
	:param: s
	:param: t
	*/
	public init (_ p: vec3, _ s: vec3, _ t: vec3) {
		values = [p, p + s, p + s + t, p + t]
		indexlist = [0, 1, 2, 2, 3, 0]
	}
	
	
	/**
	Initializes the geometry, so that center of the parallelogram is at vec3(0, 0, 0)
	
	:param: s
	:param: t
	*/
	public init (_ s: vec3, _ t: vec3) {
		self.init(-0.5 * (s + t), s, t)
	}
	
	
	// METHODS
	// +++++++
	
	/**
	Returns the buffer data for vertex at given index 
	
	:param: atIndex The index of the vertex as array
	:returns:
	*/
	public func getBufferData(atIndex index: Int) -> [GLfloat] {
		return sharedVertice ? values[index].array : values[indexlist[index]].array
	}
	
	
	public func append(value: vec3) -> Int {
		return -1
	}
	
	
	public func extend(values: [vec3]) {}
	
	public func indexOf(value: vec3) -> Int? {
		return find(values, value)
	}
}