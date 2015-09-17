//
//  GLparallelpiped.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 30.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

//
//  GLparallelogram.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 28.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLparallelepiped : GLGeometry {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides a list of positions of the geometry
	public private(set) var values : [vec3] = []
	
	/// Provides the index list
	public private(set) var indexlist : [Int] = []
	
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the size of a vertex
	public var size : Int {get {return 3}}
	
	/// Indicates whether the vertices change often or not
	public var dynamic : Bool {get {return false}}
	
	/// Indicates if the vertice are shared (element array) or not (array)
	public var sharedVertice : Bool = false
	
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
	
	- parameter p: The position to start the parallelogram from
	- parameter s:
	- parameter t:
	*/
	public init? (_ p: vec3, _ a: vec3, _ b: vec3, _ c: vec3) {
		let normal : vec3 = cross(a, r: b).normalized
		
		let inverse : Bool = dot(normal, r: c.normalized) < 0
		let x : vec3 = a
		let y : vec3 = b
		let z : vec3
		let origin : vec3
		
		if inverse {
			z = -c
			origin = p + c
		}
		else {
			z = c
			origin = p
		}
		
		let leftBottomFar : vec3 = inverse ? p - c : p
		let rightBottomFar : vec3 = leftBottomFar + x
		let leftTopFar : vec3 = leftBottomFar + y
		let leftBottomNear : vec3 = leftBottomFar + z
		
		let rightTopNear : vec3 = leftBottomFar + x + y + z
		let leftTopNear : vec3 = leftBottomFar + y + z
		let rightBottomNear : vec3 = leftBottomFar + x + z
		let rightTopFar : vec3 = leftBottomFar + x + y
		
		values = [
			leftBottomFar, rightBottomFar, leftTopFar, leftBottomNear,
			rightTopNear, leftTopNear, rightBottomNear, rightTopFar
		]
		
		indexlist = [
			0, 2, 1, 7, 1, 2,
			0, 1, 3, 6, 3, 1,
			0, 3, 2, 5, 2, 3,
			
			5, 3, 4, 6, 4, 3,
			4, 7, 5, 2, 5, 7,
			7, 4, 1, 6, 1, 4
		]
	}
	
	
	public init? (_ a: vec3, _ b: vec3, _ c: vec3) {
		let p : vec3 = -0.5 * (a + b + c)
		self.init(p, a, b, c)
	}
	
	
	// METHODS
	// +++++++
	
	/**
	Returns the buffer data for vertex at given index
	
	- parameter atIndex: The index of the vertex as array
	- returns:
	*/
	public func getBufferData(atIndex index: Int) -> [GLfloat] {
		return values[index].array
	}
	
	
	public func append(value: vec3) -> Int {
		return -1
	}
	
	
	public func extend(values: [vec3]) {}
	
	
	public func indexOf(value: vec3) -> Int? {
		return values.indexOf(value)
	}
}