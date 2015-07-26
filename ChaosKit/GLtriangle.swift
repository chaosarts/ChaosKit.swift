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
		get {return cross(b - a, c - a)}
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
	
	/**
	Returns the tangent space of the triangl according to given texcoordinates
	*/
	public func getTangentSpace (texCoord1: vec2, _ texCoord2: vec2, _ texCoord3: vec2) -> GLtangentspace? {
		let ds1 : Float = texCoord2.x - texCoord1.x
		let dt1 : Float = texCoord2.y - texCoord1.y
		let ds2 : Float = texCoord3.x - texCoord1.x
		let dt2 : Float = texCoord3.y - texCoord1.y
		
		let quotient : Float = 1.0 / (ds1 * dt2 - ds2 * dt1)
		
		let q1 : vec3 = b - a
		let q2 : vec3 = c - a
		
		let tangent : vec3 = vec3(
			dt2 * q1.x - dt1 * q2.x,
			dt2 * q1.y - dt1 * q2.y,
			dt2 * q1.z - dt1 * q2.z
		) * quotient
		
		let bitangent : vec3 = vec3(
			-ds2 * q1.x + ds1 * q2.x,
			-ds2 * q1.y + ds1 * q2.y,
			-ds2 * q1.z + ds1 * q2.z
		) * quotient
		
		return GLtangentspace(t: tangent, b: bitangent, n: normal)
	}
}