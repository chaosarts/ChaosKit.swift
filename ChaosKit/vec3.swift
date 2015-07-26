//
//  vec3.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

/// Struct for vectors in 3d
public struct vec3 : Vector {
	
	// STATIC PROPERTIES
	// +++++++++++++++++
	
	/// Provides the count of elements per rows
	public static let rows : Int = 3
	
	/// Provides the count of elements per columns
	public static let cols : Int = 1
	
	/// Provides the size of the matrix in byte
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/// Provides the count of elements
	public static var elementCount : Int {get {return rows * cols}}
	
	
	// STORED PROPERTIES
	// +++++++++++++++++
	
	/// Provides the internal representation of the vector
	private var _vec : (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
	
	
	// DERIVED PROPERTIES
	// +++++++++++++++++
	
	/// The x component of the vector
	public var x : GLfloat {
		get {return _vec.x} set {_vec.x = newValue}
	}
	
	/// The y component of the vector
	public var y : GLfloat {
		get {return _vec.y} set {_vec.y = newValue}
	}
	
	/// The z component of the vector
	public var z : GLfloat {
		get {return _vec.z} set {_vec.z = newValue}
	}
	
	/// The xy components as vec2
	public var xx : vec2 {
		get {return vec2(_vec.x, _vec.x)}
	}
	
	/// The xy components as vec2
	public var xy : vec2 {
		get {return vec2(_vec.x, _vec.y)}
	}
	
	/// The xy components as vec2
	public var xz : vec2 {
		get {return vec2(_vec.x, _vec.z)}
	}
	
	/// The xy components as vec2
	public var yx : vec2 {
		get {return vec2(_vec.y, _vec.x)}
	}
	
	/// The xy components as vec2
	public var yy : vec2 {
		get {return vec2(_vec.y, _vec.y)}
	}
	
	/// The xy components as vec2
	public var yz : vec2 {
		get {return vec2(_vec.y, _vec.z)}
	}
	
	/// The xy components as vec2
	public var zx : vec2 {
		get {return vec2(_vec.z, _vec.x)}
	}
	
	/// The xy components as vec2
	public var zy : vec2 {
		get {return vec2(_vec.z, _vec.y)}
	}
	
	/// The xy components as vec2
	public var zz : vec2 {
		get {return vec2(_vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxx : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxy : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xxz : vec3 {
		get {return vec3(_vec.x, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyx : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyy : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xyz : vec3 {
		get {return vec3(_vec.x, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzx : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzy : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var xzz : vec3 {
		get {return vec3(_vec.x, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxx : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxy : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yxz : vec3 {
		get {return vec3(_vec.y, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyx : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyy : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yyz : vec3 {
		get {return vec3(_vec.y, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzx : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzy : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var yzz : vec3 {
		get {return vec3(_vec.y, _vec.z, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxx : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxy : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zxz : vec3 {
		get {return vec3(_vec.z, _vec.x, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyx : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyy : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zyz : vec3 {
		get {return vec3(_vec.z, _vec.y, _vec.z)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzx : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.x)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzy : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.y)}
	}
	
	/// Selector to return a vec3 with components as the varname is written
	public var zzz : vec3 {
		get {return vec3(_vec.z, _vec.z, _vec.z)}
	}
	
	/// The array representation of the vector
	public var array : [GLfloat] {
		return [x, y, z]
	}
	
	/// The magnitude of the vector
	public var magnitude : GLfloat {
		return sqrt(dot(self, self))
	}
	
	/// Provides the normalized (unit length) of this vector
	public var normalized : vec3 {
		let m = magnitude
		return vec3(x/m, y/m, z/m)
	}
	
	
	// INITIALIZERS AND METHODS
	// ++++++++++++++++++++++++
	
	/** Default initializer */
	public init () {}
	
	
	/**
	Initializes the vector with x, y and z component
	
	:param: x The x component
	:param: y The y component
	:param: z The z component
	*/
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
		_vec = (x, y, z)
	}
	
	
	/**
	Initializes the vector with all components having given value
	*/
	public init (_ value : GLfloat) {
		_vec = (value, value, value)
	}
	
	
	/**
	Initializes the vector from a vec2 and a scalar
	
	:param: x The x component
	:param: v The vector containing two components for this vector
	*/
	public init (_ x: GLfloat, _ v: vec2) {
		_vec = (x, v.x, v.y)
	}
	
	
	/**
	Initializes the vector from a vec2 and a scalar
	
	:param: v The vector containing two components for this vector
	:param: z The z component
	*/
	public init (_ v: vec2, _ z: GLfloat = 0.0) {
		_vec = (v.x, v.y, z)
	}
	
	
	/**
	Initializes the vector from a vec4 by taking x, y and z
	
	:param: v The vector containing three components for this vector
	*/
	public init (_ v: vec4) {
		_vec = (v.x, v.y, v.z)
	}
	
	
	/**
	Initializes the vector from an array
	
	:param: array
	*/
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
		y = array.count > 1 ? array[1] : 0
		z = array.count > 2 ? array[2] : 0
	}
	
	
	public subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: return x
			case 1: return y
			default: return z
			}
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			case 1: y = newValue
			default: z = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < Int(vec3.elementCount)
	}
}


extension vec3 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
	}
}

extension vec3 : Printable {
	public var description : String {get {return "(\(x), \(y), \(z))"}}
}

extension vec3 : Equatable {}

public func ==(l: vec3, r: vec3) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
}


public prefix func -(v: vec3) -> vec3 {
	return vec3(-v.x, -v.y, -v.z)
}


public func +(l: vec3, r: vec3) -> vec3 {
	return vec3(l.x + r.x, l.y + r.y, l.z + r.z)
}


public func -(l: vec3, r: vec3) -> vec3 {
	return l + -r
}


public func *(l: vec3, r: vec3) -> vec3 {
	return vec3(l.x * r.x, l.y * r.y, l.z * r.z)
}


public func *(l: vec3, r: GLfloat) -> vec3 {
	return vec3(l.x * r, l.y * r, l.z * r)
}


public func *(l: GLfloat, r: vec3) -> vec3 {
	return r * l
}


public func dot (l: vec3, r: vec3) -> GLfloat {
	return l.x * r.x + l.y * r.y + l.z * r.z
}


public func cross(l: vec3, r: vec3) -> vec3 {
	return vec3(
		l.y * r.z - l.z * r.y,
		l.z * r.x - l.x * r.z,
		l.x * r.y - l.y * r.x
	)
}


public func gramschmidt (a: vec3, b: vec3, c: vec3) -> [vec3] {
	let x : vec3 = a
	let xdot : Float = dot(x, x)
	let y : vec3 = b - (dot(x, b) / xdot) * x
	let z : vec3 = c - (dot(x, c) / xdot) * x - (dot(y, c) / dot(y, y)) * y
	return [x, y, z]
}


public func makeRightHandBasis (a: vec3, b: vec3, c: vec3) -> [vec3] {
	return [a, b, dot(cross(a, b), c) > 0 ? c : -c]
}


public func makeLeftHandBasis (a: vec3, b: vec3, c: vec3) -> [vec3] {
	return [a, b, dot(cross(a, b), c) < 0 ? c : -c]
}