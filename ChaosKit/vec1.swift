//
//  vec2.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public typealias scalar = vec1

public struct vec1 : Vector {
	
	public static let rows : Int = 1
	
	public static let cols : Int = 1
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	/** The x component of the vector */
	public var x: GLfloat = 0
	
	
	/** Provides the vector as array */
	public var array : [GLfloat] {
		get {return [x]}
	}
	
	/** Provides the magnitude of the vector */
	public var magnitude : GLfloat {
		return x
	}
	
	/** Provides the normalized version of this vector */
	public var normalized : vec1 {
		var m : GLfloat = magnitude
		return vec1(x / m)
	}
	
	
	/**
	Initializes the vector with x and y equals zero
	*/
	public init () {}
	
	
	/**
	Initializes the vector with x and y arguments
	
	:param: x
	:param: y
	*/
	public init (_ x: GLfloat) {
		self.x = x
	}
	
	public init (_ v: vec1) {
		x = v.x
	}
	
	
	/**
	Initializes the vector with vec3. The z component will be discarded
	*/
	public init (_ v: vec2) {
		self.x = v.x
	}
	
	
	/**
	Initializes the vector with vec3. The z and w component will be discarded
	*/
	public init (_ v: vec3) {
		x = v.x
	}
	
	
	/**
	Initializes the vector with vec3. The z and w component will be discarded
	*/
	public init (_ v: vec4) {
		x = v.x
	}
}

extension vec1 : ArrayLiteralConvertible {
	
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
	}
	
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
	}
}

extension vec1 : IntegerLiteralConvertible {
	public init (integerLiteral: IntegerLiteralType) {
		x = GLfloat(integerLiteral)
	}
}


extension vec1 : FloatLiteralConvertible {
	public init (floatLiteral: FloatLiteralType) {
		x = GLfloat(floatLiteral)
	}
}

extension vec1 : Equatable {}

public func ==(l: vec1, r: vec1) -> Bool {
	return l.x == r.x
}

extension vec1 : Printable {
	public var description : String {
		get {return "(\(x))"}
	}
}


public prefix func -(v: vec1) -> vec1 {
	return vec1(-v.x)
}


public func +(l: vec1, r: vec1) -> vec1 {
	return vec1(l.x + r.x)
}


public func -(l: vec1, r: vec1) -> vec1 {
	return l + -r
}


public func *(l: vec1, r: vec1) -> vec1 {
	return vec1(l.x * r.x)
}


public func *(l: GLfloat, r: vec1) -> vec1 {
	return vec1(l * r.x)
}


public func *(l: vec1, r: GLfloat) -> vec1 {
	return r * l
}