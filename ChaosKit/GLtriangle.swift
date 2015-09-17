//
//  GLtriangle.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/**
Struct representing a triangle primitive. It stores the three points in space of
which the triangle consists. The struct helps to easily get the normal of the 
triangle and the tangent space for texmaps.
*/
public struct GLtriangle : GLPrimitive {
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the first point of the triangle
	public var a : vec3
	
	/// Provides the second point of the triangle
	public var b : vec3
	
	/// Provides the third point of the triangle
	public var c : vec3
	
	// DERIVED PROPERTIES
	// ++++++++++++++++++
	
	/// Provides the list of values
	public var values : [vec3] {get {return [a, b, c]}}
	
	/// Provides the normal of the triangle (righthand)
	public var normal : vec3 {
		get {return cross(b - a, r: c - a)}
	}
	
	
	// INITIALIZERS
	// ++++++++++++
	
	/// Initializes the triangle
	public init (_ a: vec3, _ b: vec3, _ c: vec3) {
		self.a = a
		self.b = b
		self.c = c
	}
	
	
	// METHODS
	// +++++++
	
	
	public static func fromGeometry (geom: GLGeometry) -> [GLtriangle] {
		var triangles : [GLtriangle] = []
		var queue : Queue = Queue(geom.indexlist)
		repeat {
			let a : vec3 = geom.values[queue.dequeue()!]
			let b : vec3 = geom.values[queue.dequeue()!]
			let c : vec3 = geom.values[queue.dequeue()!]
			triangles.append(GLtriangle(a, b, c))
		} while(queue.count > 2)
		
		return triangles
	}
	
	
	public static func fromGeometry (geom: GLGeometry, _ index: Int) -> GLtriangle? {
		let startIndex : Int = index * 3
		if startIndex + 2 >= geom.indexlist.count {return nil}
		
		let a : vec3 = geom.values[geom.indexlist[startIndex]]
		let b : vec3 = geom.values[geom.indexlist[startIndex + 1]]
		let c : vec3 = geom.values[geom.indexlist[startIndex + 2]]
		
		return GLtriangle(a, b, c)
	}
	
	
	public static func fromGeometry (geom: GLGeometry, _ point: vec3) -> [GLtriangle] {
		
		let index : Int! = geom.indexOf(point)
		if nil == index {return []}
		
		var triangles : [GLtriangle] = []
		
		for i in 0..<geom.indexlist.count - 2 {
			if geom.indexlist[i] != index {continue}
			
			let modulo : Int = i % 3
			let startIndex : Int = i - modulo
			
			/// Use `point` as first triangle point and keep
			/// order by circling through index with modulo
			let a : vec3 = geom.values[geom.indexlist[startIndex + modulo]]
			let b : vec3 = geom.values[geom.indexlist[startIndex + (modulo + 1) % 3]]
			let c : vec3 = geom.values[geom.indexlist[startIndex + (modulo + 2) % 3]]
			
			triangles.append(GLtriangle(a, b, c))
		}
		
		return triangles
	}
}


extension GLtriangle : Equatable {

}

public func ==(lhs: GLtriangle, rhs: GLtriangle) -> Bool {
	return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c
}
