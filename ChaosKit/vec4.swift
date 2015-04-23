//
//  vec4.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec4 : Vector {
	public static let rows : Int = 4
	
	public static let cols : Int = 1
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	private var vec : (x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) = (0, 0, 0, 0)
	
	
	public var x : GLfloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y : GLfloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var z : GLfloat {
		get {return vec.z} set {vec.z = newValue}
	}
	
	public var w : GLfloat {
		get {return vec.w} set {vec.w = newValue}
	}
	
	public var array : [GLfloat] {
		return [x, y, z, w]
	}
	
	public var magnitude : GLfloat {
		return sqrt(self * self)
	}
	
	public var normalized : vec4 {
		let m = magnitude
		return vec4(x/m, y/m, z/m, w/m)
	}
	
	public init () {
		
	}
	
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat, _ w: GLfloat) {
		vec = (x, y, z, w)
	}
	
	public init (_ v: vec2) {
		vec = (v.x, v.y, 0, 0)
	}
	
	public init (_ v: vec3) {
		vec = (v.x, v.y, v.z, 0)
	}
	
	
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
		y = array.count > 1 ? array[1] : 0
		z = array.count > 2 ? array[2] : 0
		w = array.count > 3 ? array[3] : 0
	}
	
	subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: return x
			case 1: return y
			case 2: return z
			default: return w
			}
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			case 1: y = newValue
			case 2: z = newValue
			default: w = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < Int(vec4.elementCount)
	}
}


extension vec4 : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
		w = elements.count > 3 ? elements[3] : 0
	}
}


extension vec4 : Printable {
	public var description : String {get {return "(\(x), \(y), \(z), \(w))"}}
}


extension vec4 : Equatable {}

public func ==(l: vec4, r: vec4) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z && l.w == r.w
}


public prefix func -(v: vec4) -> vec4 {
	return vec4(-v.x, -v.y, -v.z, -v.w)
}


public func +(l: vec4, r: vec4) -> vec4 {
	return vec4(l.x + r.x, l.y + r.y, l.z + r.z, l.w + r.w)
}


public func -(l: vec4, r: vec4) -> vec4 {
	return l + -r
}


public func *(l: vec4, r: vec4) -> GLfloat {
	let a : GLfloat = l.x * r.x + l.y * r.y
	let b : GLfloat = l.z * r.z + l.w * r.w
	return a + b
}


public func *(l: vec4, r: GLfloat) -> vec4 {
	return vec4(l.x * r, l.y * r, l.z * r, l.w * r)
}


public func *(l: GLfloat, r: vec4) -> vec4 {
	return r * l
}