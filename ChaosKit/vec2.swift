//
//  vec2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation


public struct vec2 : Vector {
	
	public static let rows : Int = 2
	
	public static let cols : Int = 1
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	/** The internal representation of the vector */
	private var _vec : (x: GLfloat, y: GLfloat) = (0, 0)
	
	/** The x component of the vector */
	public var x: GLfloat {
		get {return _vec.x} set {_vec.x = newValue}
	}
	
	/** The y component of the vector */
	public var y: GLfloat {
		get {return _vec.y} set {_vec.y = newValue}
	}
	
	/** Provides the vector as array */
	public var array : [GLfloat] {
		get {return [x, y]}
	}
	
	/** Provides the magnitude of the vector */
	public var magnitude : GLfloat {
		return sqrt(self * self)
	}
	
	/** Provides the vector that is perpendicular to this vector */
	public var normal : vec2 {
		return vec2(-y, x)
	}
	
	/** Provides the normalized version of this vector */
	public var normalized : vec2 {
		var m : GLfloat = magnitude
		return vec2(x / m, y / m)
	}
	
	
	/** 
	Initializes the vector with x and y equals zero 
	*/
	public init () {}
	
	
	public init (_ x: GLfloat) {
		_vec = (x, x)
	}
	
	/** 
	Initializes the vector with x and y arguments 
	
	:param: x
	:param: y
	*/
	public init (_ x: GLfloat, _ y: GLfloat) {
		_vec = (x, y)
	}
	
	/**
	Initializes the vector with vec3. The z component will be discarded
	*/
	public init (_ v: vec1) {
		_vec = (v.x, 0.0)
	}
	
	/**
	Initializes the vector with vec3. The z component will be discarded
	*/
	public init (_ v: vec2) {
		_vec = (v.x, v.y)
	}
	
	
	/** 
	Initializes the vector with vec3. The z component will be discarded
	*/
	public init (_ v: vec3) {
		_vec = (v.x, v.y)
	}
	
	
	/**
	Initializes the vector with vec3. The z and w component will be discarded
	*/
	public init (_ v: vec4) {
		_vec = (v.x, v.y)
	}
	
	
	public subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			return index == 0 ? x : y
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			default: y = newValue
			}
		}
	}
	
	
	
	private func valid(index: Int) -> Bool {
		return index == 0 || index == 1
	}
}

extension vec2 : ArrayLiteralConvertible {
	
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
		y = array.count > 1 ? array[1] : 0
	}
	
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
	}
}

extension vec2 : Equatable {}

public func ==(l: vec2, r: vec2) -> Bool {
	return l.x == r.x && l.y == r.y
}

extension vec2 : Printable {
	public var description : String {
		get {return "(\(x), \(y))"}
	}
}


public prefix func -(v: vec2) -> vec2 {
	return vec2(-v.x, -v.y)
}


public func +(l: vec2, r: vec2) -> vec2 {
	return vec2(l.x + r.x, l.y + r.y)
}


public func -(l: vec2, r: vec2) -> vec2 {
	return l + -r
}


public func *(l: vec2, r: vec2) -> GLfloat {
	return l.x * r.x + l.y * r.y
}


public func *(l: GLfloat, r: vec2) -> vec2 {
	return vec2(l * r.x, l * r.y)
}


public func *(l: vec2, r: GLfloat) -> vec2 {
	return r * l
}


public func gramschmidt (a: vec2, b: vec2) -> [vec2] {
	let x : vec2 = a
	let y : vec2 = b - (dot(x, b) / dot(x, x)) * x
	return [x, y]
}