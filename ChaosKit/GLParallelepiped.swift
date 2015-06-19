//
//  GLParallelepiped.swift
//  Computergrafik
//
//  Created by Fu Lam Diep on 15.06.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation
import ChaosKit

/**
Geometry class that generates vertices for a parallelepiped by passing three vectors, that
clamps the geometry. A parallelpiped consits of 12 edges, 8 corners and 6 planes. Each plane is
a parallelogram and each plane and its opposite are parallel.
*/
public struct GLparallelepiped : GLGeometry {
	
	/// Stores the vertices of the geometry
	internal var _values : [vec3]?
	
	/// The first vector of the geometry
	public var a : vec3 {didSet {_values = nil}}
	
	/// The second vector of the geometry
	public var b : vec3 {didSet {_values = nil}}
	
	/// The third vector of the geometry
	public var c : vec3 {didSet {_values = nil}}
	
	/// Indicates if the geometry ist static or dynamic
	public var dynamic : Bool = false
	
	/// Provides the size of each vertice
	public let size : Int = 3
	
	/// Indicates if the vertice are shared vertices or not
	public let indexed : Bool = false
	
	/// The indexlist of the geometry was indexed
	public let indexlist : [Int]? = nil
	
	/// Provieds the vertice as a list of vectors
	public var values : [vec3] {mutating get {updateCache(); return _values!}}
	
	/// The count of vertice provided by the geometry
	public var count : Int {mutating get {return values.count}}
	
	/// Index access to a single vertex as array of float
	public subscript (index: Int) -> [GLfloat] {
		mutating get {return values[index].array}
	}
	
	public var normals : GLShapeProperty? {
		get {
			var array : [vec3] = []
			let basis : [vec3] = makeRightHandBasis(a, b, c)
			
			let bcnormal : vec3 = cross(b, c)
			array += Array<vec3>(count: 6, repeatedValue: bcnormal)
			array += Array<vec3>(count: 6, repeatedValue: -bcnormal)
			
			let canormal : vec3 = cross(c, a)
			array += Array<vec3>(count: 6, repeatedValue: canormal)
			array += Array<vec3>(count: 6, repeatedValue: -canormal)
			
			let abnormal : vec3 = cross(a, b)
			array += Array<vec3>(count: 6, repeatedValue: abnormal)
			array += Array<vec3>(count: 6, repeatedValue: -abnormal)
			
			return GLnormals3(values: array)
		}
	}
	
	
	/**
	Initializes the geoemtry with the given vectors to clamp 
	the parallelepiped
	
	:param: a 
	:param: b
	:param: c
	*/
	public init (_ a: vec3, _ b: vec3, _ c: vec3) {
		self.a = a
		self.b = b
		self.c = c
	}
	
	
	/**
	Initilaizes the geoemtry as unit cube
	*/
	public init () {
		self.init(vec3(1, 0, 0), vec3(0, 1, 0), vec3(0, 0, 1))
	}
	
	
	public mutating func updateCache () {
		
		if _values != nil {return}
		
		// Create a list of basis vectors
		var basis : [vec3] = makeRightHandBasis(self.a, self.b, self.c)
		_values = []
		
		// Geometry is built by a plane and its opposite by calculating for points
		// (a, b, c and d) - while a is always the same point - and their point
		// mirrored opposites. The planes are always created counter clockwise
		let a : vec3 = basis[0] + basis[1] + basis[2]
		for i in 0..<basis.count {
			let s : vec3 = 2 * basis[(i + 1) % 3]
			let t : vec3 = 2 * basis[(i + 2) % 3]
			
			let b : vec3 = a - s
			let c : vec3 = a - s - t
			let d : vec3 = a - t
			
			_values! += [a, b, c, c, d, a, -a, -b, -c, -c, -d, -a]
		}
	}
}


extension GLparallelepiped {
	
	public static func generateValues (origin o: vec3, a: vec3, b: vec3, c: vec3) {
		
	}
	
	
	public static func generateNormalValues (origin o: vec3, a: vec3, b: vec3, c: vec3) {
	
	}
}