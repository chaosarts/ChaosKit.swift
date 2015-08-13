//
//  GLtangentspace.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 23.07.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLtangentspace {
	
	/// Provides the tangent of the tangent space
	public let t : vec3
	
	/// Provides the bitangent of the tangent space
	public let b : vec3
	
	/// Provides the normal of the tangent space
	public let n : vec3
	
	/// Provides the tangent of the tangent space
	public var tangent : vec3 {get {return t}}
	
	/// Provides the bitangent of the tangent space
	public var bitangent : vec3 {get {return b}}
	
	/// Provides the normal of the tangent space
	public var normal : vec3 {get {return n}}
	
	/// Provides the orientation of the tangent space
	public var positive : Bool {
		get {
			let v : vec3 = cross(t, b)
			return dot(v, n) > 0
		}
	}
	
	/// Returns the orthonomalized tangent space
	public var orthonormalized : GLtangentspace {
		get {
			var base : [vec3] = gramschmidt(n, t, b)
			return GLtangentspace(tangent: base[1], bitangent: base[2], normal: base[0])
		}
	}
	
	
	public init (tangent: vec3, bitangent: vec3, normal: vec3) {
		t = tangent
		b = bitangent
		n = normal
	}
	
	
	public init (p1: vec3, p2: vec3, p3: vec3, c1: vec2, c2: vec2, c3: vec2) {
		let triangle : GLtriangle = GLtriangle(p1, p2, p3)
		let ds1 : Float = c2.x - c1.x
		let dt1 : Float = c2.y - c1.y
		let ds2 : Float = c3.x - c1.x
		let dt2 : Float = c3.y - c1.y
		
		let quotient : Float = 1.0 / (ds1 * dt2 - ds2 * dt1)
		
		let q1 : vec3 = p2 - p1
		let q2 : vec3 = p3 - p1
		
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
		
		self.init(tangent: tangent, bitangent: bitangent, normal: triangle.normal)
	}
}