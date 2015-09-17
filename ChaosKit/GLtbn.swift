//
//  GLtbn.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 14.09.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct GLtbn {
	
	/// Provides the tangent
	public let tangent : vec3
	
	/// Provides the bitangent
	public let bitangent : vec3
	
	/// Provides the normal
	public let normal : vec3

	/// Provides the tangent
	public var t : vec3 {get {return tangent}}
	
	/// Provides the bitangent
	public var b : vec3 {get {return bitangent}}
	
	/// Provides the normal
	public var n : vec3 {get {return normal}}
	
	/// Provides this tangent space orthonormalized
	public var orthonormalized : GLtbn {
		get {
			let vectors : [vec3] = gramschmidt(n, t, b)
			return GLtbn(vectors[1], vectors[2], vectors[0])
		}
	}
	
	public init (_ t: vec3, _ b: vec3, _ n: vec3) {
		tangent = t
		bitangent = b
		normal = n
	}
	
	
	public init (_ normal: vec3, _ p1: vec3, _ p2: vec3, _ p3: vec3, _ texc1: vec2, _ texc2: vec2, _ texc3: vec2) {
		let q1 : vec3 = p2 - p1
		let q2 : vec3 = p3 - p1
		
		let u1 : vec2 = texc2 - texc1 // |a b|	|u1.x u1.y|
		let u2 : vec2 = texc3 - texc1 // |c d|	|u2.x u2.y|
		
		let quotient : Float = 1.0 / (u1.x * u2.y - u1.y * u2.x)
		
		// Inverse matrix
		// | d -b|     | u2.y -u1.y|
		// |-c  a|  or |-u2.x  u1.x|
		
		let tangent : vec3 = vec3(
			u2.y * q1.x - u1.y * q2.x,
			u2.y * q1.y - u1.y * q2.y,
			u2.y * q1.z - u1.y * q2.z
			) * quotient
		
		let bitangent : vec3 = vec3(
			-u2.x * q1.x + u1.x * q2.x,
			-u2.x * q1.y + u1.x * q2.y,
			-u2.x * q1.z + u1.x * q2.z
			) * quotient
		
		self.init(tangent, bitangent, normal)
	}
}
